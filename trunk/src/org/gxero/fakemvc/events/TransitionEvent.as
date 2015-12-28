package org.gxero.fakemvc.events 
{
	import flash.events.Event;
	
	/**
	 * This is normally used with sg.camo.fakemvc branch containing SiteModel/NodeStateCommand, but can be used for any other generic navigational purpose.
	 * This is a bubbling event by default that is normally dispatched to main application view mediator component.
	 * 
	 * @author Glenn Ko
	 */
	public class TransitionEvent extends Event 
	{
		public var name:String; 
		
		public static var TRANSITION:String = "fakeMVCTransition";
		public static var COMPLETE:String = "fakeMVCTransitionDone";
		
		public function TransitionEvent(type:String, name:String, bubbles:Boolean=true) 
		{ 
			super(type, bubbles);
			this.name = name;
		} 
		
		public override function clone():Event 
		{ 
			return new TransitionEvent(type, name, bubbles);
		} 
		
		public override function toString():String 
		{ 
			return formatToString("TransitionEvent", "type", "name", "bubbles", "cancelable", "eventPhase"); 
		}
		
	}
	
}