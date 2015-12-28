package org.gxero.fakemvc 
{
	import org.gxero.fakemvc.interfaces.IFacadeListener;
	import org.gxero.fakemvc.interfaces.IDestroyable;
	
	/**
	 * ...
	 * @author Glenn Ko
	 */
	public class AbstractMediator implements IFacadeListener, IDestroyable
	{
		private var _mediatorName:String;
		private var _facade:BaseFacade;
		protected var viewComponent:Object;
		
		public function AbstractMediator(name:String, viewComponent:Object) 
		{
			_facade = BaseFacade.getInstance();
			_mediatorName = name;
			setViewComponent(viewComponent);
		}
		
		public function setViewComponent(vc:Object):void {
			viewComponent = vc;
		}
		public function getViewComponent():Object {
			 return viewComponent;
		}
		
		
		
		public function registerMediator(mediator:AbstractMediator):Boolean {
			return _facade.registerMediator(mediator);
		}
		public function unregisterMediator (mediator:AbstractMediator):Boolean {
			return _facade.unregisterMediator (mediator);
		}
		public function hasMediator (mediator:AbstractMediator):Boolean {
			return _facade.hasMediator(mediator.mediatorName);
		}

		public function getProxy(str:String):AbstractProxy {
			return _facade.getProxy(str);
		}
		public function getCommand(str:String):AbstractCommand {
			return _facade.getCommand(str);
		}
		
		public function listFacadeListeners():Array {
			return [];
		}
		
		public function destroy():void {
			if (viewComponent is IDestroyable) (viewComponent as IDestroyable).destroy();
			viewComponent = null;
		}
		
		public function get mediatorName():String {
			return _mediatorName;
		}
		
		public function onRegister():void {
			
		}
		public function onRemove():void {
			
		}
		
		public function mytrace(str:Object):void {
			_facade.mytrace(str);
		}
		
	}
	
}