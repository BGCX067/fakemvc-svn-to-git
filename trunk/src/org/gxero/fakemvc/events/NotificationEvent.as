package org.gxero.fakemvc.events 
{
	import flash.events.Event;
	
	/**
	 * Generic data object notification event
	 * @author Glenn Ko
	 */
	public class NotificationEvent extends Event 
	{
		
		public var data:Object;
		
		public function NotificationEvent(type:String, $data:Object=null ) 
		{ 
			data = $data;
			super(type, bubbles, cancelable);
		} 
		
		public override function clone():Event 
		{ 
			return new NotificationEvent(type, data);
		} 
		
		public override function toString():String 
		{ 
			return formatToString("NotificationEvent", "type", "bubbles", "cancelable", "eventPhase"); 
		}
		
	}
	
}