package org.gxero.fakemvc 
{
	import flash.events.EventDispatcher;
	import flash.utils.Dictionary;
	import flash.utils.getQualifiedClassName;
	import org.gxero.fakemvc.events.NotificationEvent;
	import org.gxero.fakemvc.raw.ListenerDefinition;
	
	/**
	 * A simpler, minimalistic fake MVC base facade. There is no core Model/View/Controller actors, just a hash of individual model-like proxies, view-like mediators and controller-like commands
	 * to mimic PureMVC implementation.
	 * 
	 * @author Glenn Ko
	 */
	public class BaseFacade extends EventDispatcher
	{
		
		// MODEL
		protected var _proxies:Object; 
		// VIEW
		protected var _mediators:Object;
		// CONTROLLER
		protected var _commands:Object;
		
		protected var _listeners:Dictionary;
		
		protected static var INSTANCE:BaseFacade;
		
		public function BaseFacade() 
		{
			_proxies = { };
			_mediators = { };
			_commands = { };
			trace("FakeMVC:: Single-Core BaseFacade Instantiated.");
			_listeners =  new Dictionary();
		}
		
		public static function getInstance():BaseFacade {
			if (INSTANCE == null) INSTANCE = new BaseFacade();
			return INSTANCE;
		}
		
		public function hasMediator(id:String):Boolean {
			return Boolean(_mediators[id]);
		}
		public function getMediator (id:String):AbstractMediator  {
			return _mediators[id];
		}
		
		public function getCommand(id:String):AbstractCommand {
			return _commands[id];
		}
		public function hasCommand (id:String):Boolean {
			return Boolean(_commands[id]);
		}
		
		public function getProxy(id:String):AbstractProxy {
			return _proxies[id];
		}
		public function hasProxy (id:String):Boolean {
			return Boolean(_proxies[id]);
		}
		
		public function unregisterMediator (abs:AbstractMediator):Boolean {
			var comp:AbstractMediator = _mediators[abs.mediatorName];
			//trace("Assert true:"+Boolean(comp === abs));
			if (comp == null ) return false;
			comp.onRemove ();
			var arr:Array  = _listeners[comp];
			var listenerDef:ListenerDefinition;
			for (var i:String in arr) {
				listenerDef = arr[i];
				removeEventListener(listenerDef.type, listenerDef.handler, false);
			}
			//trace(abs.mediatorName+" removing key med:"+_mediators[abs.mediatorName]);
			delete _mediators[abs.mediatorName];
			delete _listeners[comp];
			//trace("checking key med:" + _mediators[abs.mediatorName]);
			
			return true;
		}
		
		public function closeAllProxies():void {
			for (var i:String in _proxies) {
			//	trace("CLOSING ALL PROXIES:"+i);
				unregisterProxy(_proxies[i]);
			}
			_proxies = { };
		}
		
		public function closeAllMediators():void {
			for (var i:String in _mediators) {
				//trace("CLOSING ALL MEDIATORS:"+i);
				unregisterMediator(_mediators[i]);
			}
			_mediators = { };
		}
		
		public function closeAllCommands():void {
			for (var i:String in _commands) {
			//	trace("CLOSING ALL COMMANDS:"+i);
				unregisterCommand(i);
			}
			_commands = { };
		}
		
		public function closeAll():void {
			closeAllMediators();
			closeAllCommands();
			closeAllProxies();
		}
		
		public function unregisterProxy (abs:AbstractProxy):Boolean {	
			var gotProxy:Boolean = _proxies[abs.proxyName];
			if (!gotProxy) return false;
			abs.onRemove ();
			delete _proxies[abs.proxyName];
	
			return true;
		}
		
		public function unregisterCommand(id:String):Boolean {
			var comp:AbstractCommand = _commands[id];
			comp.onRemove();
			if (comp == null ) return false;
			delete _commands[id];
			return false;
		}
		
		public function registerMediator (comp:AbstractMediator):Boolean {
			var id:String  = comp.mediatorName;
			id = id ? id : getQualifiedClassName (comp).split ("::")[1];
			
			if ( _mediators[id] ) {
				trace("Mediator already registered! " + comp);
				return false;
			}  //unregisterMediator(comp);
			
			_mediators[id] = comp;
			var arr:Array  = _listeners[comp] = comp.listFacadeListeners();
			var listenerDef:ListenerDefinition;
			for (var i:String in arr) {
				listenerDef = arr[i];
				addEventListener(listenerDef.type, listenerDef.handler, false, listenerDef.priority, true);
				//mytrace("Adding listeners to " + id);
			}
			comp.onRegister ();
			return true;
		}
		public function registerCommand(comp:AbstractCommand):Boolean {
			var id:String = comp.commandName;
			id = id ? id : getQualifiedClassName(comp).split("::")[1];
			if ( _commands[id] ) {
				trace("Command already registered! " + comp);
				return false;
			}  //unregisterCommand(id);
			
			_commands[id] = comp;
			comp.onRegister();
			return true;
		}
		public function registerProxy(comp:AbstractProxy):Boolean {
			var id:String = comp.proxyName;
			id = id ? id : getQualifiedClassName(comp).split("::")[1];
			if ( _proxies[id] ) {
				trace("Proxy already registered! " + comp);
				return false;
			}  //unregisterProxy(comp);
			
			_proxies[id] = comp;
			comp.onRegister();
			return true;
		}
		
		public function mytrace(strObj:Object):void {
			dispatchEvent(new NotificationEvent("DEBUG_TRACE", {text:strObj.toString()}) );
		}
		
		
	}
	
}