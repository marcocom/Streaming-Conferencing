/*
Copyright (c) 2009 Yahoo! Inc.  All rights reserved.  
The copyrights embodied in the content of this file are licensed under the BSD (revised) open source license
*/
package com.yahoo.astra.containers.formClasses {
	/**
	 *  Methods expected to be defined by FormEventObserver. 
	 *  
	 * @author kayoh
	 */
	public interface IFormEventObserver {
		//--------------------------------------
		//  Methods
		//--------------------------------------
		/**
		 * Add formItems to be subscribed.
		 * Returns <code>IFormEventObserver</code> to force IForm instance to subscribe this observer class.
		 * 
		 * @param obserItem Iform object to be subscribe events.
		 * @return IFormEventObserver
		 * 
		 * @see com.yahoo.astra.containers.formClasses.IForm#subscribeObserver
		 */
		function subscribeObserver(obserItem : IForm) : IFormEventObserver;
		/**
		 * Remove formItems from subscription.
		 * 
		 *  @param obserItem Iform instance to be unsubscribed.
		 */
		function unsubscribeObserver(obserItem : IForm) : void;
		/**
		 * Update events every formItems(<code>IForm</code>) in subscription.
		 * 
		 * @param target String <code>FormLayoutEvent</code> type and its value.
		 * @param value Object contains value associated <code>FormLayoutEvent</code>
		 * 
		 * @see com.yahoo.astra.containers.formClasses.IForm#update
		 */
		function setUpdate(target:String, val : Object) : void;
	}
}
