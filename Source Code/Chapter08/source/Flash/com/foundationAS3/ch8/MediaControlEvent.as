package com.foundationAS3.ch8{
 	import flash.events.Event;

 	public class MediaControlEvent extends flash.events.Event {
  		public static const CONTROL_TYPE:String = "headControl";
		public static const PAUSE:String = "pause";
  		public var command:String;

  		public function MediaControlEvent( command:String ):void {
   			super( CONTROL_TYPE);
   			this.command = command;	
   		}
  	}	
}