package org.gxero.fakemvc.view 
{
	import flash.utils.Dictionary;
	import org.gxero.fakemvc.AbstractMediator;
	import org.gxero.fakemvc.interfaces.IDestroyable;
	
	/**
	 * ...
	 * @author Glenn Ko
	 */
	public class CompositeMediator extends AbstractMediator
	{
		
		protected var childMediators:Dictionary = new Dictionary();
		
		public function CompositeMediator(name:String, viewComponent:Object) 
		{
			super (name, viewComponent);
		}
		
		
		
		public function addChildMediator(abs:AbstractMediator):void {
			childMediators[abs] = true;
		}
		 public function removeChildMediator(abs:AbstractMediator):void {
			delete childMediators[abs];
		}
		
		override public function onRegister ():void {
			for (var i:* in childMediators) {
				registerMediator(i);   //if (hasMediator(i)) 
			}
		}
		
		override public function onRemove():void {
			for (var i:* in childMediators) {
				unregisterMediator(i);   //if (hasMediator(i)) 
			}
		}
		
		override public function destroy ():void {
			super.destroy ();
			for (var i:* in childMediators) {
				if (i is IDestroyable) i.destroy();
			}
		}
		
	}
	
}