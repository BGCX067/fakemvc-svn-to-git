package org.gxero.fakemvc.events 
{
	import flash.events.Event;
	
	/**
	 * Contextual resize event
	 * @author Glenn Ko
	 */
	public class ResizeEvent extends Event
	{
		public var width:Number;
		public var height:Number;
		
		public static var RESIZE:String = "gxResize";
		
		public function ResizeEvent(w:Number, h:Number, $bubbles:Boolean=false) 
		{
			super (RESIZE, $bubbles, false);
			width = w;
			height= h;
		}
		
		public override function clone():Event 
		{ 
			return new ResizeEvent(width, height, bubbles);
		} 
		
	}
	
}