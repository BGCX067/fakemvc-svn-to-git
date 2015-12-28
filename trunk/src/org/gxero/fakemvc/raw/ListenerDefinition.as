package org.gxero.fakemvc.raw 
{
	
	/**
	 * 
	 * @author Glenn Ko
	 */
	public class ListenerDefinition 
	{
		public var type:String;
		public var handler:Function;
		public var priority:int;
		
		public function ListenerDefinition($type:String, $handler:Function, $priority:int=0) 
		{
			type = $type;
			handler = $handler;
			priority = $priority;
		}
		
	}
	
}