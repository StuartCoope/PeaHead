package  {
	
	import flash.display.MovieClip;
	
	
	public class MainCharacter extends MovieClip {
		
		public var _x:Number;
		public var _y:Number;
		public var _width:Number;
		public var _height:Number;
		public var _dead:Boolean;
		public var _lives:Number;
		public var _luckyCharms:Number;
		
		public function MainCharacter() 
		{
			_lives = 3;
			_luckyCharms = 0;
			_dead = false;
		}
	}
	
}
