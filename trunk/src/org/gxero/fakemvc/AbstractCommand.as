package org.gxero.fakemvc 
{
	import org.gxero.fakemvc.events.NotificationEvent;
	import org.gxero.fakemvc.BaseFacade;
	
	
	/**
	 * ...
	 * @author Glenn Ko
	 */
	public class AbstractCommand 
	{
		private var _commandName:String;
		protected var facade:BaseFacade;
		
		public function AbstractCommand(name:String) 
		{
			facade = BaseFacade.getInstance();
			_commandName = name;
		}
		
		public function get commandName():String {
			return _commandName;
		}
		
		public function onRegister():void {
		}
		public function onRemove():void {
		}
		
		public function execute(e:NotificationEvent=null):void {
		}
		
		public function sendNotification(type:String, data:Object=null):void {
			facade.dispatchEvent( new NotificationEvent(type, data));
		}
		public function sendNotificationEvent(evt:NotificationEvent):void {
			facade.dispatchEvent( evt);
		}
		
		public function mytrace(str:Object):void {
			facade.mytrace(str);
		}
		
		
		
	}
	
}