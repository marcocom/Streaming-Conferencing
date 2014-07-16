/*
Copyright (c) 2009 Yahoo! Inc.  All rights reserved.  
The copyrights embodied in the content of this file are licensed under the BSD (revised) open source license
*/
﻿package com.yahoo.astra.fl.controls.menuBarClasses
{
	import com.yahoo.astra.fl.containers.IRendererContainer;
	import com.yahoo.astra.fl.controls.AbstractButtonRow;
	import com.yahoo.astra.fl.events.MenuButtonRowEvent;
	import com.yahoo.astra.fl.utils.UIComponentUtil;
	import com.yahoo.astra.utils.InstanceFactory;
	
	import fl.controls.Button;
	import fl.core.InvalidationType;
	import fl.core.UIComponent;
	import fl.managers.IFocusManagerComponent;
	
	import flash.display.DisplayObject;
	import flash.events.FocusEvent;
	import flash.events.KeyboardEvent;
	import flash.events.MouseEvent;
	import flash.text.TextFormat;
	import flash.ui.Keyboard;
	//--------------------------------------
	//  Events
	//--------------------------------------
	
	/**
	 * Dispatched when a MenuButton is pressed.
	 *
	 * @eventType com.yahoo.astra.fl.events.MenuButtonRowEvent.ITEM_DOWN
	 *
	 * @langversion 3.0
	 * @playerversion Flash 9.0.28.0
	 */
	[Event(name="itemDown", type="com.yahoo.astra.fl.events.MenuButtonRowEvent")]	
	
	//--------------------------------------
	//  Events
	//--------------------------------------
	
	/**
	 * Dispatched when a MenuButton is moused over.
	 *
	 * @eventType com.yahoo.astra.fl.events.MenuButtonRowEvent.ITEM_ROLL_OVER
	 *
	 * @langversion 3.0
	 * @playerversion Flash 9.0.28.0
	 */
	[Event(name="itemRollOver", type="com.yahoo.astra.fl.events.MenuButtonRowEvent")]	
	
	//--------------------------------------
	//  Events
	//--------------------------------------
	
	/**
	 * Dispatched when a MenuButton is released.
	 *
	 * @eventType com.yahoo.astra.fl.events.MenuButtonRowEvent.ITEM_UP
	 *
	 * @langversion 3.0
	 * @playerversion Flash 9.0.28.0
	 */
	[Event(name="itemUp", type="com.yahoo.astra.fl.events.MenuButtonRowEvent")]		
	
	//--------------------------------------
	//  Styles
	//--------------------------------------
	
    /**
     * The skin to be used to display the background of the button row.
     *
     * @default MenuBar_background
     *
     * @langversion 3.0
     * @playerversion Flash 9.0.28.0
     */
    [Style(name="skin", type="Class")]
	
	/**
	 * The MenuButtonRow extends AbstractButtonRow and creates a row of MenuButton instances.
	 *
	 * @see com.yahoo.astra.fl.controls.AbstractButtonRow
	 *
     * @langversion 3.0
     * @playerversion Flash 9.0.28.0
     * @author Dwight Bridges	 
	 */
	public class MenuButtonRow extends AbstractButtonRow implements IRendererContainer, IFocusManagerComponent 
	{
	//--------------------------------------
	//  Constructor
	//--------------------------------------
	
		/**
		 * Constructor.
		 */		
		public function MenuButtonRow(value:Object = null)
		{        
			super();	
			tabEnabled = false;
			_selectedIndex = _focusIndex = -1;
			if(value != null) value.addChild(this);
			this.addEventListener(FocusEvent.KEY_FOCUS_CHANGE, keyFocusChangeHandler);
			stage.addEventListener(KeyboardEvent.KEY_DOWN, navigationKeyDownHandler, false, 0, true);
		}
		
		override protected function configUI():void
		{
			_skin = getDisplayObjectInstance(getStyleValue("skin"));
			this.addChildAt(_skin, 0);			
		}
		
	//--------------------------------------
	//  Properties
	//--------------------------------------
	
		/**
		 * @private
		 */
		protected static const MENU_BUTTON_STYLES:Object = 
		{
			embedFonts: "embedFonts",
			disabledTextFormat: "disabledTextFormat",
			textFormat: "textFormat",
			textPadding: "textPadding"
		};	
		
		
		private var menuButtonStyles:Object = {};
				
		/**
		 * Creates the Accessibility class.
		 * This method is called from UIComponent.
		 *
		 * @langversion 3.0
		 * @playerversion Flash 9.0.28.0
		 */		
		public static var createAccessibilityImplementation:Function;		
				
		/**
		 * @private (protected)
		 *
		 * @langversion 3.0
		 * @playerversion Flash 9.0.28.0
		 */		
		protected var _skin:DisplayObject;
				
		/**
		 * @private
		 *
		 * @langversion 3.0
		 * @playerversion Flash 9.0.28.0
		 */		
		private static var defaultStyles:Object =
		{
			skin:"MenuBar_background"
		}	
		
		/**
		 * Gets the array of buttons 
		 *
		 * @langversion 3.0
		 * @playerversion Flash 9.0.28.0
		 */
		public function get buttons():Array
		{
			return _buttons;
		}
		
		/**
		 * @private (protected)
		 * 
		 */
		protected var _autoSizeButtonsToTextWidth:Boolean = true;
		
		/**
		 * If true, the width value of the MenuBar will be ignored.  The MenuButtons
		 * will determine their size based on the size of the text that they display.
		 * If false, the MenuBar will display at the specified width.  If this width 
		 * is less than the total width of all the MenuButtons, the text of the MenuButtons
		 * will be truncated so that they will fit in the available space. 
		 */
		public function get autoSizeButtonsToTextWidth():Boolean
		{
			return _autoSizeButtonsToTextWidth;
		}
		
		/**
		 * @private (setter)
		 */
		public function set autoSizeButtonsToTextWidth(value:Boolean):void
		{
			_autoSizeButtonsToTextWidth = value;
			if(dataProvider != null && dataProvider.length > 0) invalidate();
		}		
		
	//--------------------------------------
	//  Public Methods
	//--------------------------------------
	
		/**
		 * @copy fl.core.UIComponent#getStyleDefinition()
		 *
		 * @includeExample ../core/examples/UIComponent.getStyleDefinition.1.as -noswf
		 *
		 * @see fl.core.UIComponent#getStyle()
		 * @see fl.core.UIComponent#setStyle()
		 * @see fl.managers.StyleManager
		 *
		 * @langversion 3.0
		 * @playerversion Flash 9.0.28.0
		 */
		public static function getStyleDefinition():Object
		{
			return defaultStyles;
		}	
		
	//--------------------------------------
	//  Protected Methods
	//--------------------------------------		
		/**
		 * @private (protected)
		 *
		 * @langversion 3.0
		 * @playerversion Flash 9.0.28.0
		 * 
		 */		
		override protected function initializeAccessibility():void
		{
			if(MenuButtonRow.createAccessibilityImplementation != null)
			{
				MenuButtonRow.createAccessibilityImplementation(this);
			}
		}		
		
		/**
		 * @private (protected)
		 * 
		 * Updates the position and size of the buttons.
		 *
		 * Overrides the AbstractButtonRow <code>drawButtons</code> function.
		 *
		 * @langversion 3.0
		 * @playerversion Flash 9.0.28.0
		 */
		override protected function drawButtons():void
		{
			//xPosition and yPosition need to be configurable
			//should pull from topPadding and leftPadding variables
			//which will need to be created
			var xPosition:Number = 0;
			var yPosition:Number = 0;
			var buttonCount:int = _dataProvider.length;
			for(var i:int = 0; i < buttonCount; i++)
			{
				var button:MenuButton = this.getButton() as MenuButton;
				button.rightButton = (i == buttonCount-1 && i != 0);
				button.leftButton = (i == 0 && buttonCount > 1);
				button.addEventListener(MouseEvent.MOUSE_DOWN, buttonDownHandler, false, 0, true);
				button.addEventListener(MouseEvent.ROLL_OVER, buttonRollOverHandler, false, 0, true);
				button.addEventListener(MouseEvent.MOUSE_UP, buttonUpHandler, false, 0, true);
				this._buttons.push(button);
				
				this.copyStylesToChild(button, menuButtonStyles);
				
				var item:Object = this._dataProvider.getItemAt(i);
				button.label = this.itemToLabel(item);
				if (item.hasOwnProperty("enabled"))
				{
					button.enabled =  item.enabled=="true"?true:false;
				}
				button.selected = this._selectedIndex == i;
				if(i == this._selectedIndex)
				{
					button.setMouseState("down");
				}
				else if(i == this._focusIndex)
				{
					button.setMouseState("over");
				}
				else
				{
					button.setMouseState("up");
				}
				
				button.x = xPosition;
				button.y = yPosition;
				button.height = this.height;
				button.drawNow();
				
				xPosition += button.width;
			}
			//width changes automatically based on the size of the buttons.
			
			if(autoSizeButtonsToTextWidth)
			{
				this.width = xPosition;
			}
			else if(this.width < xPosition)
			{
				var totalWidth:Number = xPosition;
				xPosition = 0;				
				for(var j:int = 0; j < buttonCount; j++)
				{
					_buttons[j].width = this.width * (_buttons[j].width / totalWidth);
					_buttons[j].x = xPosition;
					_buttons[j].drawNow();
					xPosition += _buttons[j].width;
				}
			}
		}
		
		/**
		 * @private (protected)
		 * 
		 * Either retrieves a button from the cache or creates a new one.
		 *
		 * @langversion 3.0
		 * @playerversion Flash 9.0.28.0
		 */
		override protected function getButton():Button
		{
			var button:MenuButton;
			if(this._cachedButtons.length > 0)
			{
				button = this._cachedButtons.shift() as MenuButton;
			}
			else
			{
				button = new MenuButton();	
				button.toggle = false;	
				button.tabEnabled = false;
				this.addChild(button);
			}
			button.width = NaN;
			return button;
		}		
			
		/**
		 * @private (protected)
		 * 
		 * Captures click events from each button and dispatches the
		 * MenuButtonRowEvent.ITEM_CLICK event to listeners.
		 *
		 * @langversion 3.0
		 * @playerversion Flash 9.0.28.0
		 */
		protected function buttonDownHandler(event:MouseEvent):void
		{		
			dispatchEvent(new MenuButtonRowEvent(MenuButtonRowEvent.ITEM_DOWN, false, false, selectedIndex, event.currentTarget, event.currentTarget.label));
		}
		
		/**
		 * @private (protected)
		 * 
		 * Captures roll-over events from each button and dispatches the
		 * MenuButtonRowEvent.ITEM_ROLL_OVER event to listeners.
		 *
		 * @langversion 3.0
		 * @playerversion Flash 9.0.28.0
		 */		 
		protected function buttonRollOverHandler(event:MouseEvent):void
		{
			dispatchEvent(new MenuButtonRowEvent(MenuButtonRowEvent.ITEM_ROLL_OVER, false, false, selectedIndex, event.currentTarget, event.currentTarget.label));
		}
		
		/**
		 * @private (protected)
		 * 
		 * Capture mouseUp events from each button and dispatches the
		 * MenuButtonRowEvent.ITEM_UP event to listeners
		 *
		 * @langversion 3.0
		 * @playerversion Flash 9.0.28.0		
		 */
		protected function buttonUpHandler(event:MouseEvent):void
		{
			dispatchEvent(new MenuButtonRowEvent(MenuButtonRowEvent.ITEM_UP, false, false, selectedIndex, event.currentTarget, event.currentTarget.label));
		}
				
		/**
		 * @private (protected)
		 * 
		 * Removes unneeded buttons that were cached for a redraw.
		 *
		 * @langversion 3.0
		 * @playerversion Flash 9.0.28.0
		 */		 
		override protected function clearCache():void
		{
			var cacheLength:int = this._cachedButtons.length;
			for(var i:int = 0; i < cacheLength; i++)
			{
				var button:MenuButton = this._cachedButtons.pop() as MenuButton;
				button.removeEventListener(MouseEvent.ROLL_OVER, buttonRollOverHandler);
				button.removeEventListener(MouseEvent.MOUSE_DOWN, buttonDownHandler);
				button.removeEventListener(MouseEvent.MOUSE_UP, buttonUpHandler);
				this.removeChild(button);
			}
		}
		
		/**
		 * @private (protected)
		 *
		 * Listen for events to allow for keyboard navigation.
		 *
		 * @langversion 3.0
		 * @playerversion Flash 9.0.28.0
		 */
		override protected function navigationKeyDownHandler(event:KeyboardEvent):void
		{
			var len:int = _buttons.length - 1;
			if(_selectedIndex > -1 && len > -1)
			{
				switch(event.keyCode)
				{
					//right goes to next button
					case Keyboard.RIGHT:
						if(len == 0)
						{
							_buttons[_selectedIndex].dispatchEvent(new MouseEvent(MouseEvent.ROLL_OUT));
						}
						
							incrementSelection(1);
							
						
						break;
					//left goes to previous button
					case Keyboard.LEFT:					
						if(len == 0)
						{
							_buttons[_selectedIndex].dispatchEvent(new MouseEvent(MouseEvent.ROLL_OUT));
						}
						
							incrementSelection(-1);
							
						
						break;
				}
			}
			event.updateAfterEvent();
		}
		
		protected function incrementSelection(amount:int = 1):void
		{
			var index:int = _selectedIndex + amount;
			if(index <0) index = _buttons.length - 1;
			if(index > _buttons.length - 1) index = 0;
			if(_buttons[index].enabled)
			{
				_buttons[index].dispatchEvent(new MouseEvent(MouseEvent.ROLL_OVER));
			}
						
			else 
			{
				if(amount <0) incrementSelection(amount-1)
				else incrementSelection(amount+1);
			} 
							
		}
		/**
		 * @private (protected)
		 *
		 * disables default tab key behavior
		 * 
		 * @langversion 3.0
		 * @playerversion Flash 9.0.28.0
		 */
		protected function keyFocusChangeHandler(event:FocusEvent):void
		{
			if(event.keyCode == Keyboard.TAB)
			{
				event.preventDefault();
				event.stopPropagation();	
			}
		}
		
		override public function setStyle(style:String, value:Object):void 
		{
			//Use strict equality so we can set a style to null ... so if the instanceStyles[style] == undefined, null is still set.
			//We also need to work around the specific use case of TextFormats
			if (instanceStyles[style] === value && !(value is TextFormat)) { return; }
			if(value is InstanceFactory) 
			{
				instanceStyles[style] = UIComponentUtil.getDisplayObjectInstance(this, (value as InstanceFactory).createInstance());
			}
			else
			{
				instanceStyles[style] = value;
			}
			invalidate(InvalidationType.STYLES);
		}
		
		public function setRendererStyle(name:String, value:Object, column:uint=0):void
		{
			if(menuButtonStyles[name] == value) return;
			menuButtonStyles[name] = value;
			if(this.buttons != null && this.buttons.length > 0)
			{
				var len:int = this.buttons.length;
				for(var i:int = 0; i < this.buttons.length; i++)
				{
					this.buttons[i].setStyle(name, value);
				}
			}
		}
		
		override protected function copyStylesToChild(child:UIComponent,styleMap:Object):void 
		{
			for (var n:String in styleMap) 
			{	
				child.setStyle(n, styleMap[n]);
			}
		}	
		
		override protected function drawBackground():void
		{	
			if(_skin != this.getDisplayObjectInstance(getStyleValue("skin")))
			{
				if(this.getChildAt(0) == _skin) this.removeChildAt(0);
				_skin = getDisplayObjectInstance(getStyleValue("skin"))
				this.addChildAt(_skin, 0);
			}
			if(_skin != null)
			{
				_skin.width = this.width;
				_skin.height = this.height;
			}			
		}
	}
}