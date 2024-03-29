/*
Copyright (c) 2009 Yahoo! Inc.  All rights reserved.  
The copyrights embodied in the content of this file are licensed under the BSD (revised) open source license
*/
package com.yahoo.astra.fl.utils {
	import fl.controls.ColorPicker;
	import fl.controls.ComboBox;
	import fl.controls.LabelButton;
	import fl.controls.List;
	import fl.controls.NumericStepper;
	import fl.controls.RadioButtonGroup;
	import fl.controls.TextArea;
	import fl.controls.TextInput;
	import fl.controls.TileList;
	import fl.core.UIComponent;
	import com.yahoo.astra.fl.utils.FlValueParser;
	import com.yahoo.astra.utils.IValueParser;
	import com.yahoo.astra.utils.ValueParser;
	import flash.text.TextField;	
	/**
	 * Helper class providing easy data collection from <code>UIcomponents</code>.
	 * If the <code>source</code> is <code>UIcomponent</code> or <code>TextField</code>, <code>property</code> is optional.
	 * (e.g. If you want to collect data from <code>TextField</code>, you don't have to specify <code>property</code> as "text".)
	 *
	 * <p><strong>UIcomponent type(<code>source</code>) and default <code>property</code>:</strong></p>
	 * <dl>
	 * 	<dt><strong><code>TextInput</code></strong> : text</dt>
	 * 	<dt><strong><code>ComboBox</code></strong> : selectedItem["data"]</dt>
	 * 	<dt><strong><code>NumericStepper</code></strong> : value</dt>
	 * 	<dt><strong><code>LabelButton(Button,CheckBox, RadioButton)</code></strong> : selected</dt>
	 * 	<dt><strong><code>List, TileList</code></strong> : selectedItem[labelField]</dt>
	 * 	<dt><strong><code>ColorPicker</code></strong> : hexValue</dt>
	 * </dl>
	 * 
	 * @see com.yahoo.astra.utils.ValueParser
	 * @see com.yahoo.astra.managers.FormDataManager
	 */
	public class FlValueParser extends ValueParser implements IValueParser {
		/**
		 * Constructor
		 */
		public function FlValueParser() {
			super();
		}
		/**
		 * Return actual value set from <code>setValue</code>. 
		 * @return Object Data collected out of <code>source</code>
		 */
		override public function getValue() : Object {
			if(!this.source) return null;
			if(this.source is Array) {
				var curReturnedStr : Object = "";
				var sourceLength : int = source.length;
				for (var i : int = 0;i < sourceLength; i++) {
					var curSource : Object = this.source[i];
					if(curSource is String) {
						curReturnedStr += curSource;
						continue;
					}
					var curProperty : Object = (this.property) ? ((this.property is Array) ? this.property[i] : this.property ) : null;
					var result : Object = returnBySourceType(curSource, curProperty);
					curReturnedStr += (result) ? result.toString() : "";
				}
				return curReturnedStr;
			}
			
			return returnBySourceType(this.source, this.property);
		}
		/**
		 * @private
		 */
		private function returnBySourceType(source : Object, property : Object = null) : Object {
			if(source is UIComponent) {
				return UIcomponentsValue(source as UIComponent, property);
			} else {
				return objectValue(source, property);
			}
			return this.source;
		}
		/**
		 * @private
		 */
		private function objectValue(source : Object = null, property : Object = null) : Object {
			
			var returnedvalue : Object = source;
			switch(source) {
				case source as TextField:
					var textInput : TextField = source as TextField;
					if(!property)  property = "text";
					returnedvalue = textInput[property].toString();
					break;
					
				case source as RadioButtonGroup:
					var rBtnBrp : RadioButtonGroup = source as RadioButtonGroup;
					if(!property)  property = "selectedData";
					if(rBtnBrp[property]) returnedvalue = rBtnBrp[property];
					break;	
					
				default :
					if(source && property) returnedvalue = source[property];
					break;
			}
			return returnedvalue;
		}
		/**
		 * @private
		 */
		private function  UIcomponentsValue(UiComponent : UIComponent = null, property : Object = null) : Object {
			var returnedvalue : Object = UiComponent;
			switch(UiComponent) {
				
				/*
				 * LabelButton includes Button,CheckBox, RadioButton
				 */         
				case UiComponent as LabelButton:
					var checkBox : LabelButton = UiComponent as LabelButton;
					if(!property || property == "selected") {  
						returnedvalue = checkBox["selected"];
					} else {
						if(Boolean(checkBox["selected"])) {
							returnedvalue = property;
						} else {
							returnedvalue = checkBox["selected"];
						}
					}
					break;
          
				case UiComponent as TextInput:
					var textInput : TextInput = UiComponent as TextInput;
					if(!property)  property = "text";
					returnedvalue = textInput[property].toString();
					break;
												
				case UiComponent as ComboBox:
					var comboBox : ComboBox = UiComponent as ComboBox;
					if(!property)  property = "data";
					returnedvalue = comboBox.selectedItem[property];
					break;
											
				case UiComponent as TextArea:
					var textArea : TextArea = UiComponent as TextArea;
					if(!property)  property = "text";
					returnedvalue = textArea[property].toString();
					break;
					
				case UiComponent as NumericStepper:
					var numericStepper : NumericStepper = UiComponent as NumericStepper;
					if(!property)  property = "value";
					returnedvalue = numericStepper[property];
					break;
				
				case UiComponent as List:
					var list : List = UiComponent as List;
					if(!property)  property = list.labelField;
					returnedvalue = list.selectedItem[property];
					break;  
          
				case UiComponent as TileList:
					var tilelist : TileList = UiComponent as TileList;
					if(!property)  property = tilelist.labelField;
					returnedvalue = tilelist.selectedItem[property];
					break;	
					
				case UiComponent as ColorPicker:
					var colorPicker : ColorPicker = UiComponent as ColorPicker;
					if(!property)  property = "hexValue";
					returnedvalue = colorPicker[property];
					break;
			}
			return returnedvalue;
		}
	}
}
