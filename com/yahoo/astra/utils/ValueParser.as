/*
Copyright (c) 2009 Yahoo! Inc.  All rights reserved.  
The copyrights embodied in the content of this file are licensed under the BSD (revised) open source license
*/
package com.yahoo.astra.utils {
	import com.yahoo.astra.utils.IValueParser;
	import flash.text.TextField;	
	/**
	 * ValueParser is a helper class that provides easy data collection from an object. It stores the <code>source</code> object and <code>property</code> to be collected, and return the actual value of it.
	 * <code>ValueParser</code> stores <code>source</code> and <code>property</code> of target data object, 
	 * and calling the function(<code>setValue</code>) when the target object is ready to be collected data.
	 * 
	 * @example The following code shows a use of <code>ValueParser</code> and <code>FlValueParser</code>:
	 *	<listing version="3.0">
	 * import com.yahoo.astra.utils.ValueParser;
	 * import com.yahoo.astra.fl.utils.FlValueParser;
	 * import fl.controls.ComboBox;
	 * import fl.controls.Button;
	 * import fl.controls.TextInput;
	 * import fl.data.DataProvider;
	 * 
	 * var addressLine1:TextInput = new TextInput();
	 * var addressLine2:TextInput = new TextInput();
	 * addressLine1.text = "701 First Ave";
	 * addressLine2.text = "Sunnyvale";
	 * addressLine2.y = 25;
	 * this.addChild(addressLine1);
	 * this.addChild(addressLine2);
	 * 
	 * var myComboBox:ComboBox = statesComboBox();
	 * myComboBox.y = 50;
	 * this.addChild(myComboBox);
	 * 
	 * var submitButton:Button = new Button();
	 * submitButton.label ="Submit";
	 * submitButton.y = 75;
	 * submitButton.addEventListener(MouseEvent.CLICK, clickHandler);
	 * this.addChild(submitButton);
	 * 
	 * var myValueObect:Object = {myProperty: "State"};
	 * var myObjectValue:Function = new ValueParser().setValue(myValueObect, "myProperty");
	 * var myComboBoxValue:Function = new FlValueParser().setValue(myComboBox, "abbreviation");
	 * var myAddressInputs:Function = new FlValueParser().setValue([addressLine1,"\n",addressLine2]);
	 * 
	 * function clickHandler(e:MouseEvent):void {
	 * 	trace(myObjectValue()+":"+myComboBoxValue())
	 * 	trace(myAddressInputs());
	 *	 	// State:CA
	 * 		// 701 First Ave
	 * 		// Sunnyvale
	 * }
	 * function statesComboBox():ComboBox {
	 * 	var items : XML =&lt;items&rt;
	 * 		&lt;item label="California" abbreviation="CA" / &gt;
	 * 		&lt;item label="Tennessee" abbreviation="TN" / &gt;
	 * 		&lt;item label="New York" abbreviation="NY" / &gt;
	 * 		&lt;/items&gt;
	 * 	var comboBox : ComboBox = new ComboBox();
	 * 	comboBox.dataProvider =  new DataProvider(items);
	 * 	return comboBox;
	 * }
	 *
	 *	</listing>
	 * @see com.yahoo.astra.managers.FormDataManager
	 * @see com.yahoo.astra.fl.utils.FlValueParser
	 * @author kayoh
	 */
	public class ValueParser implements IValueParser {
		protected var source : Object = null;
		protected var property : Object = null;
		/**
		 * Sets <code>source</code> and <code>property</code> of data. Returns <code>getValue</code> function as object.
		 * See the use of <code>ValueParser</code> in <code>FormDataManager</code>.
		 * 
		 * @return Function <code>getValue</code> function.
		 * 
		 * @param source Object contained data.
		 * @param property Property of the source object. If <code>source<code> is TextField, <code>property</code> will be set as "text" be default.
		 */
		public function setValue(source : Object = null, property : Object = null) : Function {
			this.source = source;
			this.property = property;
			
			return getValue;
		}
		/**
		 * Returns actual value set from <code>setValue</code>. 
		 * 
		 * @return Object Data collected out of <code>source</code>
		 */
		public function getValue() : Object {
			if(!this.source) return null;
			// if the source is Array, will return the result as a string.
			if(this.source is Array) {
				var curReturnedStr : Object = "";
				var sourceLength : int = source.length;
				for (var i : int = 0;i < sourceLength; i++) {
					var curSource : Object = this.source[i];
					var curProperty : Object = (this.property) ? ((this.property is Array) ? this.property[i] : this.property ) : null;
					var result : Object = objectValue(curSource, curProperty);
					curReturnedStr += (result) ? result.toString() : "";
				}
				return curReturnedStr;
			}
			
			return objectValue(this.source, this.property);
			
			return this.source;
		}
		/**
		 * @private
		 * 
		 * If source is TextField, property will be set as "text".
		 */
		private function objectValue(source : Object = null, property : Object = null) : Object {
			var returnedvalue : Object = source;
			
			if(source is TextField) {
				var textInput : TextField = source as TextField;
				if(!property)  property = "text";
				returnedvalue = textInput[property];
			} else {
				if(source && property) returnedvalue = source[property];
			}
			return returnedvalue;
		}
	}
}
