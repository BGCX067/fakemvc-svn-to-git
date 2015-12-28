package org.gxero.fakemvc.view 
{
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	import org.gxero.fakemvc.AbstractMediator;
	import org.gxero.fakemvc.interfaces.IDestroyable;
	
	/**
	 * ...
	 * @author Glenn Ko
	 */
	public class CompositeMediatorBase extends CompositeMediator
	{
		protected var _base:Sprite;
		
		public function CompositeMediatorBase(name:String, viewComponent:Sprite) 
		{
			super (name, viewComponent);
			_base = viewComponent;
		}

		protected function registerAndAdd(abs:AbstractMediator):void {
			registerMediator(abs);
			_base.addChild( abs.getViewComponent() as DisplayObject);  // assumption that component is at least display object
		}
		protected function unregisterAndRemove(abs:AbstractMediator):void {
			unregisterMediator(abs);
			_base.removeChild( abs.getViewComponent() as DisplayObject);  // assumption that component is at least display object
		}
		
		
	}
	
}