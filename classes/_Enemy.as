package  {
	import flash.display.MovieClip;
		public class _Enemy extends MovieClip {
	
		private var onGround:Boolean;
		private var speed:int;
		private var dead:Boolean;
		
		//-1: left, 1: right, 0: stationary.
		public var direction:int;
		
		public function _Enemy() {
			onGround = false;
			dead = false;
			direction = -1;
			speed = 3;
		}
		
		public function getHitBlock():MovieClip{
			var newBlock:MovieClip = new MovieClip;
			newBlock.x = this.x;
			newBlock.y = this.y;
			newBlock.graphics.beginFill(0xFF0000, 1);
			newBlock.graphics.drawRect(0, 0, this.width, this.height);
			newBlock.graphics.endFill();
			return newBlock;
		}
		
		public function getOnGround():Boolean{
			
			return onGround;
			
		}
		public function setOnGround(b:Boolean){
			onGround = b;
		}
		
		public function isDead():Boolean{
			return this.dead;
		}
		
		public function kill():void{
			this.dead = true;
		}
		
		//-1: left, 1: right, 0: stationary.
		public function setDirection(d:int){
			direction = d;
		}
		
		
		//-1: left, 1: right, 0: stationary.
		public function getDirection():int{
			return direction;
		}
		
		public function randomiseDirection():int{
			
			return direction;
		}
		
		public function setSpeed(i:int){
			speed = i;
		}
		
		public function getSpeed():int{
			return speed;
		}
	}
}
