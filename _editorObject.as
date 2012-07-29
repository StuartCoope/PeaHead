package  {
	import flash.display.MovieClip;
	import flash.events.MouseEvent;
	import flash.utils.Timer;
	import flash.events.TimerEvent;
	import flash.display.Stage;

	public class _editorObject extends MovieClip{
		
		var clickTimer:Timer;
		var stageObj:Stage = stage;
		public var _command:String;
		public var _tooltip:MovieClip;
		public var _type:String;

		public function _editorObject(){
			this._type = "drop";
			this.addEventListener(MouseEvent.MOUSE_DOWN, _mouseDown);
		}
		
		function _mouseUp(e:MouseEvent):void{
			clicked();
			clickTimer.removeEventListener(TimerEvent.TIMER_COMPLETE, mouseExpire);
		}
		
		function _mouseDown(e:MouseEvent):void{
			//start timer
			//add up listener
			this.addEventListener(MouseEvent.MOUSE_UP, _mouseUp);
			clickTimer = new Timer(200, 1);
			clickTimer.addEventListener(TimerEvent.TIMER_COMPLETE, mouseExpire); 
			clickTimer.start();
		}
		
		function mouseExpire(e:TimerEvent):void{
			this.removeEventListener(MouseEvent.MOUSE_UP, _mouseUp);
			clickTimer.removeEventListener(TimerEvent.TIMER_COMPLETE, mouseExpire);
		}
		
		function clicked():void{
			if(this._type == "drag" || this._type == "drop"){
				try{
						
					MovieClip(this.root).currentTool._tooltip.stopDrag();
					MovieClip(this.root).removeChild(MovieClip(this.root).currentTool._tooltip);
					
				}catch(e:Error){
					
				}
							
				if(this._tooltip != null){
					_tooltip.visible = true;
					MovieClip(this.root).currentTool = this;
					MovieClip(this.root).addChild(_tooltip);
					MovieClip(this.root).currentTool._tooltip.startDrag(this._tooltip);
				}else{
					MovieClip(this.root).currentTool = this;
				}
			}else if(this._command == "play"){
				MovieClip(this.root).playLevel();
			}else if(this._command == "XML"){
				MovieClip(this.root).xmlClicked();
			}else if(this._command == "Clear"){
				MovieClip(this.root).clearLevel();
			}else if(this._command == "Quit"){
				MovieClip(this.root).quitClicked();
			}
			
		}
	

	}
	
}