package  {
	
	import flash.display.MovieClip;
	
	
	public class BeanCan extends MovieClip {
		
		
		public function BeanCan() {
			// constructor code
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
	

	}
	
}
