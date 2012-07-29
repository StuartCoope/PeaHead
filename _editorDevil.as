package  {
	import flash.display.MovieClip;
	
	public class _editorDevil extends _editorObject{
		
		public function _editorDevil() {
			
		}
		
		public function getTooltip():MovieClip{
			return new _devilTooltip();
		}
		
		public function getCreationString():String{
			return "";
		}

	}
	
}
