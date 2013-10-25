package  {
	
	import flash.display.Sprite;
	import flash.system.Security;
	
	public class UI extends Sprite {
		
		
		public function UI() {
			// constructor code
			flash.system.Security.allowDomain("*"); 
		}
	}
	
}
