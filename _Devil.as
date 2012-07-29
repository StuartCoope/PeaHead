package  {
	import flash.display.MovieClip;
	
	public class _Devil extends _Enemy {

		
		public function _Devil() {
			super.setOnGround(false);
			super.setDirection(-1);
			super.setSpeed(3);
		}
		
		public override function getHitBlock():MovieClip{
			var newBlock:MovieClip = new MovieClip;
			newBlock.x = this.x;
			
			if(super.getDirection() == 1){
				newBlock.x -= this.width/2;
			}
			
			newBlock.y = this.y+20;
			newBlock.graphics.beginFill(0xFF0000, 1);
			newBlock.graphics.drawRect(0, 0, (this.width*0.5), this.height-20);
			newBlock.graphics.endFill();
			return newBlock;
		}
		
	}
}
