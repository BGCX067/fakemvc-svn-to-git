package org.gxero.fakemvc 
{
	import org.gxero.fakemvc.events.NotificationEvent;
	import org.gxero.fakemvc.BaseFacade;
	import org.gxero.fakemvc.interfaces.IDestroyable;
	
	
	/**
	 * ...
	 * @author Glenn Ko
	 */
	public class AbstractProxy implements IDestroyable
	{
		
		private var _proxyName:String;
		protected var data:Object;
		protected var facade:BaseFacade;
			
		public function AbstractProxy(name:String, data:Object) 
		{
			facade = BaseFacade.getInstance();
			_proxyName = name;
			setData(data);
		}
		
		public function getData():Object {
			return data;
		}
		public function setData(obj:Object):void {
			data = obj;
		}
		
		public function get proxyName():String {
			return _proxyName;
		}
		
		public function onRegister():void {}
		public function onRemove():void { }
		
		
		public function destroy():void {
			if (data is IDestroyable) (data as IDestroyable).destroy();
			data = null;
		}
		
		public function sendNotification(type:String, data:Object=null):void {
			facade.dispatchEvent( new NotificationEvent(type, data) );
		}
		public function sendNotificationEvent(evt:NotificationEvent):void {
			facade.dispatchEvent( evt);
		}
			
		public function mytrace(str:Object):void {
			facade.mytrace(str);
		}	
		
	}
	
}