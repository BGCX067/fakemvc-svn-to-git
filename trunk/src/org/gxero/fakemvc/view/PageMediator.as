package org.gxero.fakemvc.view 
{
	import flash.display.Sprite;
	import org.gxero.fakemvc.AbstractMediator;
	
	/**
	 * ...
	 * @author Glenn Ko
	 */
	public class PageMediator extends AbstractMediator
	{
		
		protected var _base:Sprite;
		
		private var pageList:Array = [];

		public function PageMediator(name:String, base:Sprite) 
		{
			super (name, base);
			_base = base;
		}
		
		
		
		
		
	}
	
}