/*
Copyright (c) 2009 Yahoo! Inc.  All rights reserved.  
The copyrights embodied in the content of this file are licensed under the BSD (revised) open source license
*/
﻿package com.yahoo.astra.fl.accessibility
{
	
import com.yahoo.astra.accessibility.EventTypes;
import com.yahoo.astra.accessibility.ObjectRoles;
import com.yahoo.astra.accessibility.ObjectStates;
import com.yahoo.astra.fl.controls.MenuBar;
import com.yahoo.astra.fl.events.MenuEvent;
import fl.accessibility.AccImpl;
import fl.core.UIComponent;
import flash.accessibility.Accessibility;
import flash.events.Event;
/**
 *  The MenuBarAccImpl class is the accessibility class for MenuBar.
 *
 * @author Alaric Cole
 */
public class MenuBarAccImpl extends AccImpl
{
	//--------------------------------------------------------------------------
	//
	//  Class initialization
	//
	//--------------------------------------------------------------------------
	/**
	 *  @private
	 *  Static variable triggering the hookAccessibility() method.
	 *  This is used for initializing MenuBarAccImpl class to hook its
	 *  createAccessibilityImplementation() method to MenuBar class 
	 *  before it gets called from UIComponent.
	 */
	private static var accessibilityHooked:Boolean = hookAccessibility();
	/**
	 *  @private
	 *  Static method for swapping the createAccessibilityImplementation()
	 *  method of MenuBar with the MenuBarAccImpl class.
	 */
	private static function hookAccessibility():Boolean
	{
		MenuBar.createAccessibilityImplementation = createAccessibilityImplementation;
		return true;
	}
	
	//--------------------------------------------------------------------------
	//
	//  Class methods
	//
	//--------------------------------------------------------------------------
	/**
	 *  @private
	 *  Method for creating the Accessibility class.
	 *  This method is called from UIComponent.
	 *  @review
	 */
	private static function createAccessibilityImplementation(component:UIComponent):void
	{
		component.accessibilityImplementation = new MenuBarAccImpl(component);
	}
	/**
	 *  Method call for enabling accessibility for a component.
	 *  This method is required for the compiler to activate
	 *  the accessibility classes for a component.
	 */
	public static function enableAccessibility():void
	{
		
	}
	//--------------------------------------------------------------------------
	//
	//  Constructor
	//
	//--------------------------------------------------------------------------
	/**
	 *  Constructor.
	 *
	 *  @param master The UIComponent instance that this AccImpl instance
	 *  is making accessible.
	 */
	public function MenuBarAccImpl(master:UIComponent)
	{
		super(master);
		role = ObjectRoles.ROLE_SYSTEM_MENUBAR;//0x02;
	}
	/**
	 *  @private
	 *	Array of events that we should listen for from the master component.
	 */
	override protected function get eventsToHandle():Array
	{
		return super.eventsToHandle.concat(
			[ "menuShow", "menuHide", "focusIn", "focusOut" ]);
	}
	
	/**
	 *  @inheritDoc
	 */
	override public function get_accRole(childID:uint):uint
	{
		if (childID == 0)
			return role;
			
		return ObjectRoles.ROLE_SYSTEM_MENUITEM;
	}
	/**
	 *  @inheritDoc
	 */
	override public function get_accState(childID:uint):uint
	{
		var accState:uint = getState(childID);
		
		if (childID > 0)
		{
			var menuBar:MenuBar = MenuBar(master);
			var index:int = childID - 1;
			if (!menuBar.menus[index] || !menuBar.menus[index].enabled)
			{
				accState |= ObjectStates.STATE_SYSTEM_UNAVAILABLE;
			}
			else
			{
				accState |= ObjectStates.STATE_SYSTEM_SELECTABLE | ObjectStates.STATE_SYSTEM_FOCUSABLE;
				
 				if (index == menuBar.selectedIndex)
					accState |= ObjectStates.STATE_SYSTEM_HOTTRACKED | ObjectStates.STATE_SYSTEM_FOCUSED; 
			}
		}
		return accState;
	}
	/**
	 *  @inheritDoc
	 */
	override public function get_accDefaultAction(childID:uint):String
	{
		if (childID == 0)
			return null;
		
		//return childID - 1 == MenuBar(master).selectedIndex ? "Close" : "Open";
		return "Open";
	}
	/**
	 *  @inheritDoc
	 */
	override public function accDoDefaultAction(childID:uint):void
	{
		if (childID > 0)
		{
			var index:int = childID - 1;
			//MenuBar(master).selectedIndex = index;
			//MenuBar(master).showMenu(index);
		}
	}
 	/**
	 *  @inheritDoc
	 */
	override public function getChildIDArray():Array
	{
		var childIDs:Array = [];
		
		if (MenuBar(master).menus)
		{
			var n:int = MenuBar(master).menus.length;
			for (var i:int = 0; i < n; i++)
			{
				childIDs[i] = i + 1;
			}
		}
		return childIDs;
	}
 	/**
	 *  @inheritDoc
	 */
	override public function accLocation(childID:uint):*
	{
		//should check that this is returning the needed component
		return MenuBar(master).menus[childID - 1];
		//return MenuBar(master).getMenuBarItemAt(childID - 1);
	}
	/**
	 *  @inheritDoc
	 */
	override public function get_accFocus():uint
	{
		var index:int = 0//MenuBar(master).selectedIndex;
		
		return index >= 0 ? index + 1 : 0;
	}
	/**
	 *  @inheritDoc
	 */
	override protected function getName(childID:uint):String
	{
		if (childID == 0)
			return "";
		var menuBar:MenuBar = MenuBar(master);
		var index:int = childID - 1;
		
		/* if (menuBar.menus && menuBar.menus.length > index)
		{
			if (menuBar.menus[index] && menuBar.menus[index].dataProvider)
				return Menu(null).itemToLabel(menuBar.menus[index].data);
		} 
		*/
		return "MenuBar";
	}
	 /**
	  * @inheritDoc
	  */
	override public function get_accValue(childID:uint):String
	{
		if (childID > 0)
			return "";
		var menuBar:MenuBar = MenuBar(master);
		var accValue:String = "MenuBar";
		 var selectedIndex:int = menuBar.selectedIndex;
		if (selectedIndex > -1)
		{
			var item:Object = menuBar.menus[selectedIndex];
			accValue = item.toString();
		} 
		return accValue;
	}
	
	/**
	 *  @private
	 *  Override the generic event handler.
	 *  All AccImpl must implement this
	 *  to listen for events from its master component. 
	 */
	override protected function eventHandler(event:Event):void
	{
		switch (event.type)
		{
			case "menuShow":
			{
				var index:int = 0; //MenuBar(master).selectedIndex;
				
				if(Accessibility.active) 
				{
					if (index >= 0 && !MenuEvent(event).menu.parentMenu)
					{
						var childID:uint = index + 1;
	
						Accessibility.sendEvent(master, childID, EventTypes.EVENT_OBJECT_FOCUS);
	
						Accessibility.sendEvent(master, childID, EventTypes.EVENT_OBJECT_SELECTION);
					}
				}
				break;
			}
			case "menuHide":
			{
				if (!MenuEvent(event).menu.parentMenu)
				if(Accessibility.active) 
				{
					Accessibility.sendEvent(master, 0, EventTypes.EVENT_OBJECT_MENUPOPUPEND);
				}
				break;
			}
 
			case "focusIn":
			{
				if(Accessibility.active) 
				{
					Accessibility.sendEvent(master, 0, EventTypes.EVENT_OBJECT_SELECTION);
				}
				break;
			}
			
			/* case "focusOut":
			{
				if (MenuBar(master).selectedIndex == -1)
				{
					if(Accessibility.active) 
					{
						Accessibility.sendEvent(master, 0, EventTypes.EVENT_OBJECT_MENUPOPUPEND);
					}
				}
				break;
			} 
			*/
		}
	}
}
}
