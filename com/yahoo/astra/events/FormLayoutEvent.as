/*
Copyright (c) 2009 Yahoo! Inc.  All rights reserved.  
The copyrights embodied in the content of this file are licensed under the BSD (revised) open source license
*/
package com.yahoo.astra.events {
	import flash.events.Event;		
	/**
	 * Events definitions for <code>Form</code> and <code>FormItem</code>.
	 * 
	 * @author kayoh
	 */
	public class FormLayoutEvent extends Event {
		//--------------------------------------------------------------------------
		//
		//  Constants
		//
		//--------------------------------------------------------------------------
	
		/**
		 *   Defines the value of the <code>type</code> property of a  
		 * <code>formBuildFinished</code> event object. 
		 *  @eventType formBuildFinished
		 */
		public static const FORM_BUILD_FINISHED : String = "formBuildFinished";
		/**
		 *  The <code>FormLayoutEvent.UPDATE_GOT_REQUIRED_ITEM</code> constant defines the property type of <code>update</code> methods.
		 *
		 *  @eventType updateGotRequiredItem
		 */
		public static const UPDATE_GOT_REQUIRED_ITEM : String = "updateGotRequiredItem";
		/**
		 *  The <code>FormLayoutEvent.UPDATE_LABEL_FONT_CHG</code> constant defines the property type of <code>update</code> methods.
		 *
		 *  @eventType updateLabelFont
		 */
		public static const UPDATE_LABEL_FONT_CHANGE : String = "updateLabelFont";
		/**
		 *  The <code>FormLayoutEvent.UPDATE_INSTRUCTION_FONT_CHG</code> constant defines the property type of <code>update</code> methods.
		 *
		 *  @eventType updateInstructionFont
		 */
		public static const UPDATE_INSTRUCTION_FONT_CHANGE : String = "updateInstructionFont";
		/**
		 *  The <code>FormLayoutEvent.UPDATE_ERROR_MSG_TEXT</code> constant defines the property type of <code>update</code> methods.
		 *
		 *  @eventType updateErrorMsgText
		 */
		public static const UPDATE_ERROR_MSG_TEXT : String = "updateErrorMsgText";
		/**
		 *  The <code>FormLayoutEvent.UPDATE_ERROR_MSG_BOX</code> constant defines the property type of <code>update</code> methods.
		 *
		 *  @eventType updateErrorMsgBox
		 */
		public static const UPDATE_ERROR_MSG_BOX : String = "updateErrorMsgBox";
		/**
		 *  The <code>FormLayoutEvent.UPDATE_HORIZONTAL_GAP</code> constant defines the property type of <code>update</code> methods.
		 *
		 *  @eventType updateHorizontalGap
		 */
		public static const UPDATE_HORIZONTAL_GAP : String = "updateHorizontalGap";
		/**
		 *  The <code>FormLayoutEvent.UPDATE_ITEM_HORIZONTAL_GAP</code> constant defines the property type of <code>update</code> methods.
		 *
		 *  @eventType updateItemHorizontalGap
		 */
		public static const UPDATE_ITEM_HORIZONTAL_GAP : String = "updateItemHorizontalGap";
		/**
		 *  The <code>FormLayoutEvent.UPDATE_ITEM_VERTICAL_GAP</code> constant defines the property type of <code>update</code> methods.
		 *
		 *  @eventType updateItemVeticalGap
		 */
		public static const UPDATE_ITEM_VERTICAL_GAP : String = "updateItemVeticalGap";
		/**
		 *  The <code>FormLayoutEvent.UPDATE_LABEL_ALIGN</code> constant defines the property type of <code>update</code> methods.
		 *
		 *  @eventType updateLableAlign
		 */
		public static const UPDATE_LABEL_ALIGN : String = "updateLableAlign";
		/**
		 *  The <code>FormLayoutEvent.UPDATE_REQUIRED_ITEM</code> constant defines the property type of <code>update</code> methods.
		 *
		 *  @eventType updateRequiredItem
		 */
		public static const UPDATE_REQUIRED_ITEM : String = "updateRequiredItem";
		/**
		 *  The <code>FormLayoutEvent.UPDATE_INDICATOR_LOCATION</code> constant defines the property type of <code>update</code> methods.
		 *
		 *  @eventType updateIndicatiorLocation
		 */
		public static const UPDATE_INDICATOR_LOCATION : String = "updateIndicatiorLocation";
		/**
		 *  The <code>FormLayoutEvent.UPDATE_LABEL_WIDTH</code> constant defines the property type of <code>update</code> methods.
		 *
		 *  @eventType updateLabelWidth
		 */
		public static const UPDATE_LABEL_WIDTH : String = "updateLabelWidth";
		/**
		 *  The <code>FormLayoutEvent.UPDATED_PADDING_RIGHT</code> constant defines the property type of <code>update</code> methods.
		 *
		 *  @eventType updatePaddingRight
		 */
		public static const UPDATED_PADDING_RIGHT : String = "updatePaddingRight";
		/**
		 * Defines the value of the <code>type</code> property of a  
		 * <code>labelAdded</code> event object. 
		 * 
		 *  @eventType labelAdded
		 */
		public static const LABEL_ADDED : String = "labelAdded";
		/**
		 * Defines the value of the <code>type</code> property of a  
		 * <code>indicatorSizeChange</code> event object. 
		 * 
		 *  @eventType indicatorSizeChange
		 */
		public static const INDICATOR_SIZE_CHAGE : String = "indicatorSizeChange";
		
		//--------------------------------------------------------------------------
		//
		//  Constructor
		//
		//--------------------------------------------------------------------------
		/**
		 *  Constructor.
		 *
		 *  @param type The event type; indicates the action that caused the event.
		 *
		 *  @param bubbles Specifies whether the event can bubble up the display list hierarchy.
		 *
		 *  @param cancelable Specifies whether the behavior associated with the event can be prevented.
		 *
		 */
		public function FormLayoutEvent(type : String, bubbles : Boolean = false, cancelable : Boolean = false) {
			super(type, bubbles, cancelable);
		}
		/**
		 * @private
		 */
		override public function clone() : Event {
			return new FormLayoutEvent(this.type, this.bubbles, this.cancelable);
		}
	}
}
