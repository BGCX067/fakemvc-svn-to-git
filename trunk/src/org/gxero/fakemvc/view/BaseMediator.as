package org.gxero.fakemvc.view 
{
	import flash.events.IEventDispatcher;
	import flash.utils.Dictionary;
	import org.gxero.fakemvc.AbstractMediator;
	import org.gxero.fakemvc.raw.ListenerDefinition;
	
	/**
	* Basic mediator class that stores a hash of local listeners so you can remove all of them at once you unregister it
	* from the facade.
	* @author Glenn Ko
	*/
	public class BaseMediator extends AbstractMediator
	{
		
		protected var LOCAL_LISTENERS:Dictionary = new Dictionary();
		
		public function BaseMediator(name:String, viewComponent:Object) 
		{
			super(name, viewComponent);
		}
		
		override public function onRemove():void {
			removeAllLocalListeners();
		}
		
		protected function removeAllLocalListenersFrom(targ:IEventDispatcher):void
		{
			var chkArray:Array = LOCAL_LISTENERS[targ];
			if (chkArray == null) return;
			for each (var def:ListenerDefinition in chkArray) {
				targ.removeEventListener(def.type, def.handler);
			}
			delete LOCAL_LISTENERS[targ];
		}
		
		protected function addLocalListener(targ:IEventDispatcher, type:String, handler:Function, priority:int=0) {
			var chkArray:Array = LOCAL_LISTENERS[targ];
			if (chkArray == null) {
				chkArray = [new ListenerDefinition (type, handler, priority)];
				LOCAL_LISTENERS[targ] = chkArray;
			}
			else {
				chkArray.push( new ListenerDefinition(type, handler, priority) );
			}
			
			targ.addEventListener(type, handler, false, priority, true);
		}
		
		protected function removeAllLocalListeners ():void {
			for (var i:* in LOCAL_LISTENERS) {
				var chkArray:Array = LOCAL_LISTENERS[i];
				for each (var def:ListenerDefinition in chkArray) {
					i.removeEventListener(def.type, def.handler);
				}
				delete LOCAL_LISTENERS[i];
			}
		}
	
		protected function removeLocalListener (targ:IEventDispatcher, type:String):void {
			var chkArray:Array = LOCAL_LISTENERS[targ];
			if (chkArray == null) return;
			var len:int = chkArray.length;
			var i:int = chkArray.length;
			while ( --i > -1) {
				var def:ListenerDefinition = chkArray[i];
				if (def.type === type) {
					targ.removeEventListener (def.type, def.handler);
					chkArray.splice(i,1);
					i--;
				}
			}
		}
		
		protected function removeListener(targ:IEventDispatcher, type:String, handler:Function):void {
			if (targ.hasEventListener(type)) targ.removeEventListener(type, handler);
		}
		
		protected function addListener(targ:IEventDispatcher, type:String, handler:Function, priority:int=0):void {
			if (!targ.hasEventListener(type)) targ.addEventListener(type, handler, false , priority, true);
		}
		
		
		
	}
	
}