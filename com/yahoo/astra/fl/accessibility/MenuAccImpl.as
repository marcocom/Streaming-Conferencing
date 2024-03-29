/*
Copyright (c) 2009 Yahoo! Inc.  All rights reserved.  
The copyrights embodied in the content of this file are licensed under the BSD (revised) open source license
*/
﻿package com.yahoo.astra.fl.accessibility
{
import com.yahoo.astra.accessibility.EventTypes;
import com.yahoo.astra.accessibility.ObjectRoles;
import com.yahoo.astra.accessibility.ObjectStates;
import com.yahoo.astra.fl.controls.Menu;
import com.yahoo.astra.fl.controls.menuClasses.MenuCellRenderer;
import com.yahoo.astra.fl.events.MenuEvent;
import fl.accessibility.ListAccImpl;
import fl.core.UIComponent;
import flash.accessibility.Accessibility;
import flash.events.Event;
/**
 * The MenuAccImpl class is used to make a Menu component accessible.
 * 
 * <p>A Menu reports the role <code>ObjectRoles.ROLE_SYSTEM_MENUPOPUP</code> (0x0b) to a screen 
 * reader. Items of a Menu report the role <code>ObjectRoles.ROLE_SYSTEM_MENUITEM</code> (0x0c).</p>
 *
 *
 * @see com.yahoo.astra.fl.controls.Menu Menu
 * @see http://msdn.microsoft.com/en-us/library/ms697502(VS.85).aspx Microsoft Accessibility Developer Center User Interface Element Reference: Pop-Up Menu
 *
 * @author Alaric Cole
 */
public class MenuAccImpl extends ListAccImpl
{
	//--------------------------------------------------------------------------
	//
	//  Class initialization
	//
	//--------------------------------------------------------------------------
	/**
	 *  Static variable triggering the <code>hookAccessibility()</code> method.
	 *  This is used for initializing <code>MenuAccImpl</code> class to hook its
	 *  <code>createAccessibilityImplementation()</code> method to the <code>Menu</code> class 
	 *  before it gets called when <code>UIComponent</code> invokes the <code>initializeAccessibility()</code> method.
	 * 
	 *  @see fl.accessibility.UIComponent#createAccessibilityImplementation()
	 *  @see fl.accessibility.UIComponent#initializeAccessibility()
	 *  @see fl.accessibility.UIComponent#initialize()
	 */
	private static var accessibilityHooked:Boolean = hookAccessibility();
	/**
	 *  Static method that swaps the <code>createAccessibilityImplementation()</code>
	 *  method of <code>UIComponent</code> subclass with the appropriate <code>AccImpl</code> subclass.
	 * 
	 *  @see fl.accessibility.UIComponent#createAccessibilityImplementation()
	 *  @see fl.accessibility.UIComponent#initializeAccessibility()
	 *  @see fl.accessibility.UIComponent#initialize()
	 */
	private static function hookAccessibility():Boolean
	{
		Menu.createAccessibilityImplementation = createAccessibilityImplementation;
		return true;
	}
	/**
	 *  Method for creating the Accessibility Implementation class for a component.
	 *  <p>This method is called by the <code>initializeAccessibility()</code> method for the <code>UIComponent</code> subclass when the component initalizes.</p>
	 *  <p>All <code>AccImpl</code> subclasses must implement this method</p>
	 * 
	 *  @param component The UIComponent instance that this MenuAccImpl instance makes accessible.
	 * 
	 *  @see fl.accessibility.AccImpl#createAccessibilityImplementation()
	 *  @see fl.core.UIComponent#createAccessibilityImplementation() 
	 *  @see fl.core.UIComponent#initalizeAccessibility()
	 *  @see fl.core.UIComponent#initialize()
	 */
	public static function createAccessibilityImplementation(component:UIComponent):void
	{
		component.accessibilityImplementation = new MenuAccImpl(component);
	}
	/**
	 *  Method call for enabling accessibility for a component.
	 *  This method is required for the compiler to activate the accessibility classes for a component.
	 * 
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
	 * Creates a new MenuAccImpl instance for the specified Menu component.
	 *
	 * @param master The UIComponent instance that this MenuAccImpl instance is making accessible.
	 * 
	 */
	public function MenuAccImpl(master:UIComponent)
	{
		super(master);
		role = ObjectRoles.ROLE_SYSTEM_MENUPOPUP;
	}
	/**
	 *  @inheritDoc
	 */
	override protected function get eventsToHandle():Array
	{
		return super.eventsToHandle.concat([ MenuEvent.ITEM_ROLL_OVER, MenuEvent.ITEM_ROLL_OUT, 
			MenuEvent.MENU_SHOW, MenuEvent.MENU_HIDE, MenuEvent.ITEM_CLICK ]);
	}
	
	/**
	 * @inheritDoc
	 * @see http://msdn.microsoft.com/en-us/library/ms697502(VS.85).aspx Microsoft Accessibility Developer Center User Interface Element Reference: Pop-Up Menu
	 */
	override public function get_accRole(childID:uint):uint
	{
		//if it's the first child, it's the Menu 
		if (childID == 0)
		{
			return role;			
		}
		//greater than zero, and it's a menu item
		return ObjectRoles.ROLE_SYSTEM_MENUITEM;
	}
	 /**
	  * @inheritDoc
	  */
	override public function get_accValue(childID:uint):String
	{
		if (childID > 0)
			return "";
		var menu:Menu = Menu(master);
		var accValue:String = "";
		var selectedIndex:int = menu.selectedIndex;
		if (selectedIndex > -1)
		{
			var item:Object = menu.dataProvider.getItemAt(selectedIndex);
			accValue = menu.itemToLabel(item);
		}
		return accValue;
	}
	/**
	 *  @inheritDoc
	 */
	override public function get_accState(childID:uint):uint
	{
		var accState:uint = getState(childID);
		if (childID > 0 && childID < 100000)
		{
			var item:Object = Menu(master).dataProvider.getItemAt(childID - 1);
			var menu:Menu = Menu(master);
			var menuItem:MenuCellRenderer = menu.itemToCellRenderer(item) as MenuCellRenderer;
			if(!menuItem.enabled)
			{
				accState |= ObjectStates.STATE_SYSTEM_UNAVAILABLE;
				return accState;
			}
			accState |= ObjectStates.STATE_SYSTEM_HOTTRACKED | ObjectStates.STATE_SYSTEM_FOCUSED;
			
			//determine if it is a checkbox menu item
			if (menuItem.data.selected)
				accState |= ObjectStates.STATE_SYSTEM_CHECKED;
				
			//if it has a submenu
			if (menuItem.data.data)
				accState |= ObjectStates.STATE_SYSTEM_HASPOPUP;
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
		var item:Object = Menu(master).dataProvider.getItemAt(childID - 1);
		var menuItem:MenuCellRenderer = Menu(master).itemToCellRenderer(item) as MenuCellRenderer;
		return menuItem.data.data ? "Open" : "Execute";
	}
	
	/**
	 *  @inheritDoc
	 */
	override protected function getName(childID:uint):String
	{
		if (childID == 0 || childID > 100000)
			return "";
		var name:String;
		var menu:Menu = Menu(master);
		var item:Object = menu.dataProvider.getItemAt(Math.max(childID - 1, 0));
		name = menu.itemToLabel(item);
		return name;
	}
	/**
	 *  @inheritDoc
	 */
	override protected function eventHandler(event:Event):void
	{
		var index:int = 0;
		var childID:uint;
		switch (event.type)
		{
			case MenuEvent.ITEM_ROLL_OVER:
			{
				index = MenuEvent(event).index;
				if (index >= 0)
				{
					if(Accessibility.active) 
					{
				
						childID = index + 1;
						Accessibility.sendEvent(MenuEvent(event).menu, childID, EventTypes.EVENT_OBJECT_FOCUS, true);
						Accessibility.sendEvent(MenuEvent(event).menu, childID, EventTypes.EVENT_OBJECT_SELECTION, true);
						Accessibility.sendEvent(MenuEvent(event).menu, childID, EventTypes.EVENT_OBJECT_MENUPOPUPSTART, true);
					}
				}
				break;
			}
			case MenuEvent.ITEM_CLICK:
			{
				index = MenuEvent(event).menu.selectedIndex;
				if (index >= 0)
				{
					if(Accessibility.active) 
					{
				
						childID = index + 1;
						Accessibility.sendEvent(MenuEvent(event).menu, childID, EventTypes.EVENT_OBJECT_FOCUS);
						Accessibility.sendEvent(MenuEvent(event).menu, childID, EventTypes.EVENT_OBJECT_SELECTION);
					}
				}
				break;
			}
			case MenuEvent.MENU_SHOW:
			{
				if(Accessibility.active) 
				{
					
					{					
						Accessibility.sendEvent(MenuEvent(event).menu, 0,
							EventTypes.EVENT_OBJECT_MENUPOPUPSTART, true);
										
					}				
				
				}
				
				
				break;
			}
			case MenuEvent.MENU_HIDE:
			{
				if(Accessibility.active) 
				{
					if(!MenuEvent(event).menu.parentMenu)
					Accessibility.sendEvent(MenuEvent(event).menu, 0, EventTypes.EVENT_OBJECT_MENUPOPUPEND);
				}
				break;
			}
			
			case "change":
				index = Menu(master).selectedIndex;
				if (index >= 0) 
				{
					if(Accessibility.active) 
					{
						childID = index + 1;
						Accessibility.sendEvent(Menu(master), childID, EventTypes.EVENT_OBJECT_FOCUS);
						Accessibility.sendEvent(Menu(master), childID, EventTypes.EVENT_OBJECT_SELECTION);
					}
				}
				break;
			
		}
	}
}
}
