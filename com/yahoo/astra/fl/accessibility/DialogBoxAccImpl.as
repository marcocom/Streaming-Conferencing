/*
Copyright (c) 2009 Yahoo! Inc.  All rights reserved.  
The copyrights embodied in the content of this file are licensed under the BSD (revised) open source license
*/
﻿package com.yahoo.astra.fl.accessibility
{
import com.yahoo.astra.accessibility.EventTypes;
import com.yahoo.astra.accessibility.ObjectRoles;
import com.yahoo.astra.accessibility.ObjectStates;
import com.yahoo.astra.fl.controls.containerClasses.DialogBox;
import fl.accessibility.AccImpl;
import fl.core.UIComponent;
import flash.accessibility.Accessibility;
import flash.accessibility.AccessibilityProperties;
import flash.events.Event;
import flash.events.MouseEvent;
/**
 *  The DialogBoxAccImpl class is the accessibility class for DialogBox.
 *
 * @author Alaric Cole
 */
public class DialogBoxAccImpl extends AccImpl
{
    
	//--------------------------------------------------------------------------
	//
	//  Class initialization
	//
	//--------------------------------------------------------------------------
	/**
	 *  @private
	 *  Static variable triggering the hookAccessibility() method.
	 *  This is used for initializing DialogBoxAccImpl class to hook its
	 *  createAccessibilityImplementation() method to DialogBox class 
	 *  before it gets called from UIComponent.
	 */
	private static var accessibilityHooked:Boolean = hookAccessibility();
	/**
	 *  @private
	 *  Static method for swapping the createAccessibilityImplementation()
	 *  method of DialogBox with the DialogBoxAccImpl class.
	 */
	private static function hookAccessibility():Boolean
	{
		DialogBox.createAccessibilityImplementation = createAccessibilityImplementation;
		
		return true;
	}
	/**
	 *  @private
	 *  Method for creating the Accessibility class.
	 *  This method is called from UIComponent.
	 *  @review
	 */
	private static function createAccessibilityImplementation( component:UIComponent):void
	{
		var dialogBox:DialogBox = component as DialogBox;
		
		var titleBar:UIComponent = dialogBox.titleBar;
		var titleBarAccImpl:DialogBoxAccImpl = new DialogBoxAccImpl(component);
		titleBar.accessibilityImplementation = titleBarAccImpl;
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
	public function DialogBoxAccImpl(master:UIComponent)
	{
		super(master);
		
		DialogBox(master).titleBar.addEventListener(MouseEvent.MOUSE_UP,
													 eventHandler);
		
	
		role = ObjectRoles.ROLE_SYSTEM_ALERT;
	}
	
	/**
	 *  @private
	 *	Array of events that we should listen for from the master component.
	 */
	override protected function get eventsToHandle():Array
	{
		return super.eventsToHandle.concat([ "addedToStage" ]);
	}
	
	
	/**
	 *  @inheritDoc
	 */
	override protected function getName(childID:uint):String
	{
		var name:String = DialogBox(master).titleBar.text;
		switch (childID)
		{
			case 1:
			{
				name = "";
				break;
			}
			case 2:
			{
				name = "";
				break
			}
			default:
			{
				name = DialogBox(master).titleBar.text + ", " +
					   DialogBox(master).messageText;
				break;
			}
		}
		return name;
	}
	
	/**
	 *   @inheritDoc
	 */
	override public function get_accState(childID:uint):uint
	{
		var accState:uint = getState(childID);
		
		switch (childID)
		{
			case 1:
			{
				break;
			}
			case 2:
			{
				accState |= ObjectStates.STATE_SYSTEM_FOCUSED;
				break;
			}
			default:
			{
				accState |= ObjectStates.STATE_SYSTEM_MOVEABLE;
				break;
			}
		}
		
		return accState;
	}
	
	/**
	 *   @inheritDoc
	 */
	override public function get_accRole(childID:uint):uint
	{
		var accRole:uint = role;
		
		switch (childID)
		{
			case 1:
			{
				accRole = ObjectRoles.ROLE_SYSTEM_TITLEBAR;
				break;
			}
			case 2:
			{
				accRole = ObjectRoles.ROLE_SYSTEM_DIALOG;
				break;
			}
			default:
				accRole = role;
				break;
		}
		
		return accRole;
	}
	/**
	 *   @inheritDoc
	 */
	override public function getChildIDArray():Array
	{
		var childIDs:Array = [];
		for (var i:int = 0; i < 2; ++i)
		{
			childIDs[i] = i + 1;
		}
		return childIDs;
	}
	/**
	 *   @inheritDoc
	 */
	override public function accLocation(childID:uint):*
	{
		var location:Object = master;
		
		switch (childID)
		{
			case 1:
			{
				location = DialogBox(master).titleBar;
				break;
			}
			case 2:
			{
				location = DialogBox(master).messageText;
				break;
			}
			default:
			{
				break;
			}
		}
		return location;
	}
	/**
	 *  @inheritDoc
	 */
	override protected function eventHandler(event:Event):void
	{
		var titleBar:UIComponent;
		
		switch (event.type)
		{
			case "close":
			{
				titleBar = DialogBox(master).titleBar;
				Accessibility.sendEvent(titleBar,0, EventTypes.EVENT_OBJECT_DIALOGEND); 
				Accessibility.sendEvent(titleBar,0,EventTypes.EVENT_OBJECT_REORDER); 
				Accessibility.sendEvent(titleBar,0,EventTypes.EVENT_OBJECT_DESTROY);
				Accessibility.sendEvent(titleBar,0,EventTypes.EVENT_OBJECT_LOCATIONCHANGE); 
				Accessibility.sendEvent(titleBar,0,EventTypes.EVENT_OBJECT_PARENTCHANGE); 
				Accessibility.sendEvent(titleBar,0,EventTypes.EVENT_OBJECT_HIDE); 
				Accessibility.sendEvent(titleBar,0,EventTypes.EVENT_OBJECT_FOCUS); 
				
				break;
			}
			
			case "addedToStage":
			{
				if (!master.stage.accessibilityProperties)
				{
					master.stage.accessibilityProperties =
						new AccessibilityProperties();
				}
				master.stage.accessibilityProperties.silent = false//true;
				master.visible = true;
				titleBar = DialogBox(master).titleBar;
				titleBar.tabIndex = 0;
				DialogBox(master).messageBox.textField.tabIndex = 0;
   				UIComponent(titleBar).visible = true;
				Accessibility.updateProperties();
				Accessibility.sendEvent(titleBar, 0, EventTypes.EVENT_OBJECT_SHOW ); 
				Accessibility.sendEvent(titleBar, 0, EventTypes.EVENT_OBJECT_DIALOGSTART ); 
				Accessibility.sendEvent(titleBar, 0, EventTypes.EVENT_OBJECT_REORDER); 
				Accessibility.sendEvent(titleBar, 0, EventTypes.EVENT_OBJECT_CREATE); 
				Accessibility.sendEvent(titleBar, 0, EventTypes.EVENT_OBJECT_LOCATIONCHANGE); 
				Accessibility.sendEvent(titleBar, 0, EventTypes.EVENT_OBJECT_PARENTCHANGE); 
				Accessibility.sendEvent(titleBar, 0, EventTypes.EVENT_OBJECT_SHOW); 
				Accessibility.sendEvent(titleBar, 0, EventTypes.EVENT_OBJECT_HIDE); 
				Accessibility.sendEvent(titleBar, 0, EventTypes.EVENT_OBJECT_FOCUS); 
				Accessibility.sendEvent(DialogBox(master).buttonBar._buttons[0], 0, EventTypes.EVENT_OBJECT_FOCUS); 
				break;
			}
			
		}
	}
}
}
