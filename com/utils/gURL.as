
 


package com.utils {
	import 	flash.net.URLVariables;
	import	flash.net.URLRequest;
	import	flash.net.URLLoader;
	import	flash.net.URLLoaderDataFormat;
	import	flash.net.URLRequestMethod;
	
	import	flash.events.Event;
	import	flash.events.SecurityErrorEvent;
	import  flash.events.HTTPStatusEvent;
	import	flash.events.IOErrorEvent;

	public class gURL {
		
		private var debugTxtObj:Object;
		private var initFunc:Function;
		
		public function gURL( /*initFunc:Function, debugTxtObj:Object*/ ):void {
			//this.debugTxtObj = debugTxtObj;
			//this.debugTxtObj.text += "test3\n";
			//this.initFunc = initFunc;
		}/**/
		
 
		/////////////////////////////////////////////////////////////////////////
		////////////////////  SEND START ///////////////////////////////
		/////////////////////////////////////////////////////////////////////////

		public function sendData(url:String, _vars:URLVariables):void {  
			//Security.loadPolicyFile("https://employeesavingstickets.com/crossdomain.xml");
			var request:URLRequest = new URLRequest(url);  
			var loader:URLLoader = new URLLoader();  
			loader.dataFormat = URLLoaderDataFormat.VARIABLES;  
			request.data = _vars;  
			request.method = URLRequestMethod.POST;  
			loader.addEventListener(Event.COMPLETE, handleComplete);  
			loader.addEventListener(SecurityErrorEvent.SECURITY_ERROR, securityErrorHandler);
			loader.addEventListener(Event.OPEN, openHandler);
			loader.addEventListener(HTTPStatusEvent.HTTP_STATUS, httpStatusHandler);
			loader.addEventListener(IOErrorEvent.IO_ERROR, ioErrorHandler);
			//loader.addEventListener(IOErrorEvent.IO_ERROR, onIOError);
			//loader.addEventListener(HTTPStatusEvent.HTTP_RESPONSE_STATUS, responseStatusHandler);

			loader.load(request);  
			//debug_list.addItem({label:"Data Sent", data:"0"});
			//this.debugTxtObj.text += "trying ("+url+")\n";
		} 

		private function handleComplete(event:Event):void {  
			//this.debugTxtObj.text += "handleComplete: " + event+"\n";
			var loader:URLLoader = URLLoader(event.target);  
			//this.debugTxtObj.text += "Token Returned ("+loader.data.success+" / "+loader.data.data+")\n";
			
			if(loader.data.success == 'true') {
				if(loader.data.type == 'token') {
					//token = loader.data.data;
					this.initFunc(loader.data.data);
				}
			}
			
			/*if(loader.data.msg != 'true') {
				//debug_list.addItem({label:"Session Failed ("+loader.data.msg+')', data:"0"});
				this.debugTxtObj.text += "Session Failed ("+loader.data.msg+")\n";
				
				broadcast_btn.label = "Broadcast Over"
				broadcaster.publisher.stopBroadcast()	
				broadcast_btn.enabled = false; 
				timerCont.stop();
			} else {
				//debug_list.addItem({label:"Session Validated ("+loader.data.msg+')', data:"0"});
				this.debugTxtObj.text += "Session Validated ("+loader.data.msg+")\n";
			}*/
		}  

		private function securityErrorHandler(event:SecurityErrorEvent):void {
			// debug_list.addItem({label:"securityErrorHandler: " + event, data:"0"});
			//this.debugTxtObj.text += "securityErrorHandler: " + event+"\n";
		}
		
		private function openHandler(event:Event):void {
		   // this.debugTxtObj.text += "openHandler: " + event+"\n";
		}
		
		private function httpStatusHandler(event:HTTPStatusEvent):void {
			//this.debugTxtObj.text += "httpStatusHandler: " + event+"\n";
		}

		private function ioErrorHandler(event:IOErrorEvent):void {
			 //this.debugTxtObj.text += "ioErrorHandler: " + event+"\n";
		}	
		
		/* private function responseStatusHandler(event:HTTPStatusEvent):void {
			this.debugTxtObj.text += "*responseStatusHandler*: " + event+"\n";
		}*/	
	
 
 		
		
	}


}