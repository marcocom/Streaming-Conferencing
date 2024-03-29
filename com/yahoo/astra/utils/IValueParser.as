/*
Copyright (c) 2009 Yahoo! Inc.  All rights reserved.  
The copyrights embodied in the content of this file are licensed under the BSD (revised) open source license
*/
package com.yahoo.astra.utils {
	/**
	 * Methods expected to be defined by <code>ValueParser</code> and <code>FlValueParser</code>
	 * 
	 * @see com.yahoo.astra.utils.ValueParser
	 * @see com.yahoo.astra.fl.utils.FlValueParser
	 * @author kayoh
	 */
	public interface IValueParser {
		/**
		 * Set source and property to collect data.
		 * 
		 * @return Function Return <code>getValue</code> function.
		 * 
		 * @param source Object contained data.
		 * @param property Property of the source object.
		 */
		function setValue(source : Object = null, property : Object = null) : Function ;
		 /**
     * Return actual value set from <code>setValue</code>.
     * @return Object Data collected from <code>source</code>
     */
		function getValue() : Object ;
	}
}
