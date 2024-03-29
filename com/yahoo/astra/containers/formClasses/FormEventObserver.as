/*
Copyright (c) 2009 Yahoo! Inc.  All rights reserved.  
The copyrights embodied in the content of this file are licensed under the BSD (revised) open source license
*/
﻿package com.yahoo.astra.containers.formClasses {
	import com.yahoo.astra.containers.formClasses.IForm;	
	/**
	 * Event obsever class for form classes. 
	 */
	public class FormEventObserver implements IFormEventObserver {
		//--------------------------------------
		//  Constructor
		//--------------------------------------
	
		/**
		 * Constructor.
		 * 
		 */
		public function FormEventObserver() : void {
			observers = [];
		}
		//--------------------------------------
		//  Properties
		//--------------------------------------
		/**
		 * @private
		 */
		private var observers : Array;
		//--------------------------------------
		//  internal Methods
		//--------------------------------------
		/**
		 * Adds formItems to be subscribed.
		 * Returns <code>IFormEventObserver</code> to force IForm instance to subscribe this observer class.
		 * 
		 * @param observerItem Iform object to be subscribed events.
		 * @return IFormEventObserver
		 * 
		 */
		public function subscribeObserver(observerItem : IForm) : IFormEventObserver {
			var duplicate : Boolean = false;
			for (var i : uint = 0;i < observers.length; i++) {
				if (observers[i] == observerItem) {
					duplicate = true;
				}
			}
			if (!duplicate) {
				observers.push(observerItem);
			}
			return this;
		}
		/**
		 * Removes <code>Iform</code> from subscription.
		 * 
		 *  @param observerItem Iform instance to be unsubscribed.
		 */
		public function unsubscribeObserver(observerItem : IForm) : void {
			for (var i : uint = 0;i < observers.length; i++) {
				if (observers[i] == observerItem) {
					observers.splice(i, 1);
				}
			}
		}
		/**
		 * Updates events every <code>IForm</code> in subscription.
		 * 
		 * @param target String <code>FormLayoutEvent</code> type and its value.
		 * @param value Object contains value associated <code>FormLayoutEvent</code>
		 * 
		 */
		public function setUpdate(target : String, value : Object) : void {
			for (var i:Object in this.observers) {
				observers[i].update(target, value);
			}
		}
	}
}