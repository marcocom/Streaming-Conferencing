/*
Copyright (c) 2009 Yahoo! Inc.  All rights reserved.  
The copyrights embodied in the content of this file are licensed under the BSD (revised) open source license
*/
﻿package com.yahoo.astra.fl.controls
{
	import com.yahoo.astra.fl.containers.IRendererContainer;
	import com.yahoo.astra.fl.controls.menuBarClasses.MenuButton;
	import com.yahoo.astra.fl.controls.menuBarClasses.MenuButtonRow;
	import com.yahoo.astra.fl.events.MenuButtonRowEvent;
	import com.yahoo.astra.fl.events.MenuEvent;
	import com.yahoo.astra.fl.utils.XMLUtil;
	
	import fl.core.InvalidationType;
	import fl.core.UIComponent;
	import fl.data.DataProvider;
	import fl.managers.IFocusManagerComponent;
	
	import flash.events.FocusEvent;
	import flash.events.MouseEvent;
	import flash.ui.Keyboard;
	
	//--------------------------------------
	//  Events
	//--------------------------------------	
 
	 /**
	 * Dispatched when the user clicks an item in the menu. 
	 *
	 * @eventType com.yahoo.astra.fl.events.MenuEvent.ITEM_CLICK
	 *
	 * @langversion 3.0
	 * @playerversion Flash 9.0.28.0
	 */
	[Event(name="itemClick", type="com.yahoo.astra.fl.events.MenuEvent")]		
	/**
	 * Dispatched when a menu is shown
	 *
	 * @eventType com.yahoo.astra.fl.events.MenuEvent.MENU_SHOW
	 *
	 * @langversion 3.0
	 * @playerversion Flash 9.0.28.0
	 */
	[Event(name="menuShow", type="com.yahoo.astra.fl.events.MenuEvent")]
	
	/**
	 * Dispatched when a menu is hidden.
	 *
	 * @eventType com.yahoo.astra.fl.events.MenuEvent.MENU_HIDE
	 *
	 * @langversion 3.0
	 * @playerversion Flash 9.0.28.0
	 */
	[Event(name="menuHide", type="com.yahoo.astra.fl.events.MenuEvent")]
	//--------------------------------------
	//  Styles
	//--------------------------------------	
	
	/**
	 * The number of pixels the top level menu will appear to the right of MenuBar 
	 * button.  A negative value can be used to set the menu to the left of the 
	 * MenuBar button. The default value is 5.
     *
     * @default 5
     *
     * @langversion 3.0
     * @playerversion Flash 9.0.28.0
     */	
	[Style(name="xOffset", type="Number")]
	/**
     * The number of pixels the top level menu will appear below the MenuBar button. 
	 * A negative value can be used to have the menu overlap the MenuBar button. The 
	 * default value is 5.
     *
     * @default 5
     *
     * @langversion 3.0
     * @playerversion Flash 9.0.28.0
     */	
	[Style(name="yOffset", type="Number")]
	
	
	/**
	 * The number of pixels between the left edge of the menu and the left edge of 
	 * the stage when the stage is too narrow to fit the menu. If the value were set 
	 * to 0, the left edge of the menu would be flush with the left edge of the stage. 
     *
     * @default 0
     *
     * @langversion 3.0
     * @playerversion Flash 9.0.28.0
     */	
	[Style(name="menuLeftMargin", type="Number")]
	
	/**
	 * The number of pixels between the bottom of the menuBar and the top of the 
	 * menu when the stage is to short to fit the menu. If the value were set to 0, 
	 * the top of the menu would be flush with bottom edge of the menuBar. 
     *
     * @default 0
     *
     * @langversion 3.0
     * @playerversion Flash 9.0.28.0
     */	
	[Style(name="menuTopMargin", type="Number")]	
	
	/**
	 * The number of pixels for a bottom gutter to a menu when the stage to short to 
	 * fit the menu. If the value were set to 0, the bottom of the menu would be 
	 * flush with the bottom edge of the stage. 
     *
     * @default 0
     *
     * @langversion 3.0
     * @playerversion Flash 9.0.28.0
     */	
	[Style(name="menuBottomMargin", type="Number")]	 
	/**
	 * The number of pixels between the right edge of the menu and the right edge of 
	 * the stage when the stage is too narrow to fit the menu. If the value were set 
	 * to 0, the right edge of the menu would be flush with the left edge of the 
	 * stage. 	
     *
     * @default 0
     *
     * @langversion 3.0
     * @playerversion Flash 9.0.28.0
     */	
	[Style(name="menuRightMargin", type="Number")]	 
	
	/**
	 * The number of pixels that each submenu will appear to right of its parent 
	 * menu. A negative value can be used to have the menus overlap. 
     *
     * @default -3
     *
     * @langversion 3.0
     * @playerversion Flash 9.0.28.0
     */	
	[Style(name="subMenuXOffset", type="Number")]		
	/**
	 * The number of pixels that each submenu will appear below the top of its parent 
	 * menu. A negative value can be used to have the menu appear above its parent 
	 * menu. 	
	 *
     * @default 3
     *
     * @langversion 3.0
     * @playerversion Flash 9.0.28.0
     */	
	[Style(name="subMenuYOffset", type="Number")]		
	/**
	 * The MenuBar extends the UIComponent and manages a MenuButtonRow and corresponding
	 * instances of Menu.
	 *
	 * @see fl.core.UIComponent
	 * @see com.yahoo.astra.fl.controls.MenuButtonRow
	 * @see com.yahoo.astra.fl.controls.Menu
	 *
     * @langversion 3.0
     * @playerversion Flash 9.0.28.0
     * @author Dwight Bridges	 
	 */
	public class MenuBar extends UIComponent implements IFocusManagerComponent 
	{
	//--------------------------------------
	//  Constructor
	//--------------------------------------
	
		/**
		 * Constructor.
		 */		
		public function MenuBar(value:Object = null)
		{
			super();			
			if(value != null) value.addChild(this);
			tabEnabled = true;
			_buttonRow = new MenuButtonRow(this);
			_buttonRow.height = height;
			_buttonRow.addEventListener(MenuButtonRowEvent.ITEM_DOWN, itemDownHandler, false, 0, true);
			_buttonRow.addEventListener(MenuButtonRowEvent.ITEM_ROLL_OVER, itemRollOverHandler, false, 0, true);
			_buttonRow.addEventListener(MenuButtonRowEvent.ITEM_UP, itemUpHandler, false, 0, true);		
			if(this.isLivePreview)
			{
				_buttonRow.dataProvider = new DataProvider(["No preview data available."]);	
			}			
		}
		
	//--------------------------------------
	//  Properties
	//--------------------------------------
	
        /**
         * @private
         *
         * @langversion 3.0
         * @playerversion Flash 9.0.28.0
         */
		private static var defaultStyles:Object = {
			xOffset:0,
			yOffset:0,
			menuLeftMargin:0,
			menuTopMargin:0,
			menuBottomMargin:0,
			menuRightMargin:0,
			subMenuXOffset:0,
			subMenuYOffset:0, 
			focusRectSkin:null, 
			focusRectPadding:null,
			menuBarBackground:"MenuBar_background"
		}
		
		
				/**
			     * @private (protected)
			     * @inheritDoc
				 */
				
				override protected function initializeAccessibility():void {
					if (MenuBar.createAccessibilityImplementation != null) {
						MenuBar.createAccessibilityImplementation(this);
					}
				}
		/**
		 * @private
		 */
		private static const MENU_BUTTON_STYLES:Object = 
		{
			embedFonts: "embedFonts",
			disabledTextFormat: "disabledTextFormat",
			textFormat: "textFormat",
			textPadding: "textPadding"
		};		
	
		private static var menuRendererStyles:Object = {};
		
		private static var menuBarStyles:Object = {};
		
		private static var menuBarRendererStyles:Object = {};
		
		private var menuStyles:Object = {};
		
		/**
		 * @private (protected)
		 * 
		 * Instance of the MenuButtonRow.  Contains a row of buttons that control the menu 
		 * instances.
		 */
		public var _buttonRow:MenuButtonRow;
		
		/**
		 * Gets the array of buttons
		 *
		 * @langversion 3.0
		 * @playerversion Flash 9.0.28.0
		 */
		public function get buttons():Array
		{
			return _buttonRow.buttons;
		}		
		[Inspectable(defaultValue="false",type=Boolean)]
		/**
		 * Indicates whether or not to close open menus when the mouse leaves the stage 
		 * of the flash application. The default value is false.
		 */
		public var closeMenuOnMouseLeave:Boolean = false;
		
		[Inspectable(defaultValue=true,type=Boolean)]		
		/**
		 * Indicates whether or not a menu link that spawns a child menu will be 
		 * clickable. The default value is true. 
		 */
		public var parentMenuClickable:Boolean = true;
		
		/**
		 *  
		 */
		public var selectedIndex:int = _buttonRow ? _buttonRow.selectedIndex : -1;
		
		/**
		 * Creates the Accessibility class.
		 * This method is called from UIComponent.
		 *
		 */		
		public static var createAccessibilityImplementation:Function;		
		
		/**
         * @private
         * Storage for the labelField property
		 */
		protected var _labelField:String="label";
		
	    [Inspectable(category="Data", defaultValue="label")]
	    /**
	     *  Name of the field in the items in the <code>dataProvider</code> 
	     *  Array to display as the label in the Menu.
	     *  By default, the control uses a property named <code>label</code>
	     *  on each Array object and displays it.
	     *  <p>However, if the <code>dataProvider</code> items do not contain
	     *  a <code>label</code> property, you can set the <code>labelField</code>
	     *  property to use a different property.</p>
	     *
	     */
	    public function get labelField():String
	    {
	        return _labelField;
	    }
	    /**
	     *  @private
	     */
	    public function set labelField(value:String):void
	    {
	        //support @ modifiers for XML converted to Object via XMLDataProvider
			if(value.indexOf("@") == 0) value = value.slice(1); 
	       	if (value == _labelField) { return; }
			_labelField = value;
			invalidate(InvalidationType.DATA);
		
	    }	
	    
	    /**
		 * Returns a string for the MenuBar and Menus to display.
         *
		 * @param item The data object.
		 *
         * @return String The string to be displayed based on the data.
         *
         * @see #labelField
		 */
		public function itemToLabel(item:Object):String {
			if(item is XML)
			{
				item = XMLUtil.createObjectFromXMLAttributes( item as XML);
			}
				
			return (item[_labelField]!=null) ? String(item[_labelField]) : "";
			
		}	
		/**
		 * @private (protected)
		 */
		protected var _dataProvider:DataProvider;
		
		/**
		 *  Gets or sets the hierarchical data model for display of menu items and menus. 
		 *  To use XML data, you should set the dataProvider as type <code>XMLDataProvider</code>:
		 *  <code>menubar.dataProvider = new XMLDataProvider(someXML);</code>
		 *
		 *  <p>You can also use an array of objects in the following format:
		 * 	<code>
		 * 
		 * var dp:Array = [
		 * 		{
		 * 			label:"File",
		 * 			data:
		 * 			[ 
		 * 				{ label:"File Menu item 1" }, 
		 * 				{ label:"File Menu item 2" } 
		 * 			]
		 * 		},
		 * 		{
		 * 			label:"Edit",
		 * 			data:
		 * 			[ 
		 * 				{ label:"Edit Menu item 1" }, 
		 * 				{ label:"Edit Menu item 2" } 
		 * 			]
		 * 		}
		 * ];
		 * 
		 * menubar.dataProvider = new DataProvider(dp);
		 *  </code>
		 * </p>
		 *  @see com.yahoo.astra.fl.data.XMLDataProvider
		 *  @see #labelField
		 */
		 public function get dataProvider():DataProvider
		 {
			 return _dataProvider;
		 }
		 
		/**
		 * @private (setter)
		 */
		public function set dataProvider(value:DataProvider):void
		{
			//If there is a menu open, hide it.
			if(_menus != null && _menus.length > 0 && !isNaN(_menus.length) && _buttonRow.selectedIndex > -1 && !isNaN(_buttonRow.selectedIndex))
			{
				var selectedIndex:Number = _buttonRow.selectedIndex;
				_menus[selectedIndex].hide(false);
			}
			_menus = [];
			_dataProvider = value;
			var tabValues:Array = [];
			
			
			for each (var element:* in value.toArray())
			{
				var tabValue:String =  itemToLabel(element);
				tabValues.push(tabValue); 		
				var menu:Menu = Menu.createMenu(this, element.data);
				
				menu.parentMenuClickable = parentMenuClickable;
				menu.setStyle("xOffset", Number(getStyleValue("subMenuXOffset")));
				menu.setStyle("yOffset", Number(getStyleValue("subMenuYOffset")));
				menu.setStyle("leftMargin", Number(getStyleValue("menuLeftMargin")));
				menu.setStyle("rightMargin", Number(getStyleValue("menuRightMargin")));
				menu.setStyle("topMargin", Number(getStyleValue("menuTopMargin")));
				menu.setStyle("bottomMargin", Number(getStyleValue("menuBottomMargin")));
				//this.copyRendererStylesToChild(menu, menuRendererStyles)
				menu.name = tabValue;
				menu.labelField = labelField;
				menu.closeOnMouseLeave = closeMenuOnMouseLeave;
				menu.addEventListener(MenuEvent.MENU_HIDE, clearSelected);
				menu.addEventListener(MenuEvent.ITEM_CLICK, dispatchMenuEvents);
				menu.addEventListener(MenuEvent.MENU_HIDE, dispatchMenuEvents);
				menu.addEventListener(MenuEvent.MENU_SHOW, dispatchMenuEvents);
				_menus.push(menu);
			}
			
			_buttonRow.dataProvider = new DataProvider(tabValues);
		}	
		
		/**
		 * @private (protected)
		 */
		protected var _menus:Array = [];	
		
		/**
		 * Array of menus
		 */
		public function get menus():Array
		{
			return _menus;
		}
		
		/**
		 * @private (protected)
		 *
		 * Storage for the autoSizeTabsToTextWidth property.
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
			if(value != _autoSizeButtonsToTextWidth)
			{
				_autoSizeButtonsToTextWidth  = value;
				invalidate();
			}
		}
		
		/**
		 * @private (protected)
		 */
		override protected function draw():void
		{
			_buttonRow.setSize(this.width, this.height);
			_buttonRow.autoSizeButtonsToTextWidth = autoSizeButtonsToTextWidth;
			this.copyStylesToChild(_buttonRow, menuBarStyles);
			this.copyStylesToMenus();
			this.copyRendererStylesToChild(_buttonRow, menuBarRendererStyles);
			super.draw();
			if(this.isLivePreview) _buttonRow.drawNow();
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
		 * Listens for the MenuButtonRowEvent.ITEM_UP event and toggles menus.
		 *
		 * @langversion 3.0
		 * @playerversion Flash 9.0.28.0
		 */
		protected function itemDownHandler(event:MenuButtonRowEvent):void
		{		
			var selectedIndex:int = event.index;
			var button:MenuButton = event.item as MenuButton;
			var index:int = _buttonRow.buttons.indexOf(button);
			
			if(index == selectedIndex)			
			{
				_buttonRow.selectedIndex = -1;
				_menus[index].hide();
				button.dispatchEvent(new MouseEvent(MouseEvent.ROLL_OVER));
			}
			else
			{
				if(selectedIndex != -1) _menus[selectedIndex].hide(false);
				_buttonRow.selectedIndex = index;
				_menus[index].show(button.x + Number(getStyleValue("xOffset")), button.y + button.height + Number(getStyleValue("yOffset")));
				_menus[index].setFocus();
			}
		}
		
		/**
		 * @private (protected)
		 * 
		 * Listens for the MenuButtonRowEvent.ITEM_ROLL_OVER event and toggles menus.
		 *
		 * @langversion 3.0
		 * @playerversion Flash 9.0.28.0
		 */		 
		protected function itemRollOverHandler(event:MenuButtonRowEvent):void
		{
			var button:MenuButton = event.item as MenuButton;
			var selectedIndex:int = event.index;
			var index:int = _buttonRow.buttons.indexOf(button);
			
			if(index != selectedIndex && selectedIndex != -1)
			{		
				_menus[selectedIndex].hide(false);
				_buttonRow.selectedIndex = index;
				_menus[index].show(button.x + Number(getStyleValue("xOffset")), button.y + button.height + Number(getStyleValue("yOffset")));
			}
		}
		
		/**
		 * @private (protected)
		 * 
		 * Listens for the MenuButtonRowEvent and sets focus on the selected 
		 * button.
		 *
		 * @langversion 3.0
		 * @playerversion Flash 9.0.28.0		
		 */
		protected function itemUpHandler(event:MenuButtonRowEvent):void
		{
			var selectedIndex:int = _buttonRow.selectedIndex;
			if(selectedIndex > -1) _menus[selectedIndex].setFocus();
		}
				
		/**
		 * @private (protected)
		 *
		 * Listens for the menu hide event 
		 * If the hide event came from the currently selected button, clear the selected index
		 * Used to manage the menu bar button states when the menu is closed by the active button or within the menu
		 * 
		 * @langversion 3.0
		 * @playerversion Flash 9.0.28.0
		 */		
		protected function clearSelected(event:MenuEvent):void
		{
			var selectedIndex:int = _buttonRow.selectedIndex;
			var menu:Menu = event.target as Menu;
			var index:int = _menus.indexOf(menu);
			var button:MenuButton = _buttonRow.buttons[index];	
			if(index == selectedIndex) _buttonRow.selectedIndex = -1;	
		}	
		
		/**
		 * @private (protected)
		 * 
		 * Listens for menu events and dispatches them.
		 * 
		 * @langversion 3.0
		 * @playerversion Flash 9.0.28.0
		 */	
		protected function dispatchMenuEvents(event:MenuEvent):void
		{
			dispatchEvent(event as MenuEvent);
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
		
		/**
         * @private (protected)
         *
         * @langversion 3.0
         * @playerversion Flash 9.0.28.0
		 */
		protected function copyRendererStylesToChild(child:UIComponent,styleMap:Object):void 
		{
			for (var n:String in styleMap) 
			{
				(child as IRendererContainer).setRendererStyle(n, styleMap[n]);
			}
		}	
			
		
		/**
		 *   
		 *
		 *
		 */
		public function setMenuRendererStyle(name:String, style:Object):void
		{
			if (menuRendererStyles[name] == style) { return; }
			menuRendererStyles[name] = style;
			if(this.menus != null && this.menus.length > 0) 
			{
				var len:int = this.menus.length;
				for(var i:int = 0; i < len; i++)
				{
					this.menus[i].setRendererStyle(name, style);
				}
			}
		}
		
		public function setMenuBarRendererStyle(name:String, style:Object):void
		{
			if(menuBarRendererStyles[name] == style) return;
			menuBarRendererStyles[name] = style;
			if(_buttonRow != null) _buttonRow.setRendererStyle(name, style);
		}
		
		override protected function copyStylesToChild(child:UIComponent,styleMap:Object):void 
		{
			for (var n:String in styleMap) {
				
				child.setStyle(n, styleMap[n]);
			}
		}	
		protected function copyStylesToMenus():void
		{
			if(this.menus != null && this.menus.length > 0)
			{
				var len:int = this.menus.length;
				for(var i:int = 0; i < len; i++)
				{
					this.copyStylesToChild(this.menus[i], menuStyles);
					this.copyRendererStylesToChild(this.menus[i], menuRendererStyles);
				}
			}
		}
		
		
		override public function setStyle(name:String, style:Object):void
		{
			if(menuBarStyles[name] == style) return;
			menuBarStyles[name] = style;
			if(_buttonRow != null) (_buttonRow as UIComponent).setStyle(name, style);
		}
		
		public function setMenuStyle(name:String, style:Object):void
		{
			if(menuStyles[name] == style) return;
			menuStyles[name] = style;
			if(this.menus != null && this.menus.length > 0) 
			{
				var len:int = this.menus.length;
				for(var i:int = 0; i < len; i++)
				{
					this.menus[i].setStyle(name, style);
				}
			}
		}
		
		
		
		
		
		
		
		
		
		
		
	}	
}