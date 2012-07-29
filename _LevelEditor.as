package  {
	import flash.utils.Timer;
	import flash.events.MouseEvent;
	import flash.events.TimerEvent;
	import flash.display.MovieClip;

	public class _LevelEditor extends _Level{

		var clickTimer:Timer;
		var _mouseX:Number;
		var _mouseY:Number;

		public function _LevelEditor(){
			//trace("Level editor");
			//this.addEventListener(MouseEvent.MOUSE_DOWN, _mouseDown);
		}
		/*

		function _mouseUp(e:MouseEvent):void{
			clicked(e);
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
		*/
		
		public function removeObjectAtPoint(removeX:Number, removeY:Number):void{

			//HittestPoint works locally. So adjust for the level's offset.
			removeX = this.x + removeX;
			trace("Removing: " + removeX + ", " + removeY);

			/*
			public var _platforms:Vector.<MovieClip>;
			public var _enemies:Vector.<_Enemy>;
			public var _checkPoints:Vector.<_CheckCoin>;
			public var _trinkets:Vector.<_Trinket>;
			public var _goal:_Goal;
			public var _start:_Start;
			*/
			
			var _current:Vector.<MovieClip> = super._platforms;
			
			//for each, hittestpoint(x, y);
			for each ( var object:MovieClip  in _current){
				if(object.hitTestPoint(removeX, removeY, true)){
					this.removeChild(object);
					
					for(var i:Number = 0; i < _current.length; i++){
						if(_current[i] == object){
							_current.splice(i, 1);
							trace("Platform removed, size: " + _current.length);
						}
					}
				}
			}
			
			
			var _currentEnemies:Vector.<_Enemy> = super._enemies;
			
			for each ( var object:MovieClip  in _currentEnemies){
				if(object.hitTestPoint(removeX, removeY)){
					this.removeChild(object);
					
					for(var i:Number = 0; i < _currentEnemies.length; i++){
						if(_currentEnemies[i] == object){
							_currentEnemies.splice(i, 1);
							trace("Enemy removed, size: " + _currentEnemies.length);
						}
					}
				}
			}
			
			var _currentCheckpoints:Vector.<_CheckCoin> = super._checkPoints;
			
			for each ( var object:MovieClip  in _currentCheckpoints){
				if(object.hitTestPoint(removeX, removeY)){
				
					this.removeChild(object);
				   
				   for(var i:Number = 0; i < _currentCheckpoints.length; i++){
						if(_currentCheckpoints[i] == object){
							_currentCheckpoints.splice(i, 1);
							trace("Checkpoint removed, size: " + _currentCheckpoints.length);
						}
					}
				}
			}
			
			var _currentTrinkets:Vector.<_Trinket> = super._trinkets;
			
			for each ( var object:MovieClip  in _currentTrinkets){
				if(object.hitTestPoint(removeX, removeY)){
					this.removeChild(object);
				   
				   for(var i:Number = 0; i < _currentTrinkets.length; i++){
						if(_currentTrinkets[i] == object){
							_currentTrinkets.splice(i, 1);
							trace("Trinket removed, size: " + _currentTrinkets.length);
						}
					}
				}
			}
							  
			if(super._goal != null && super._goal.hitTestPoint(removeX, removeY)){
				this.removeChild(super._goal);
				super._goal = null;
			}
				  
			if(super._start != null && super._start.hitTestPoint(removeX, removeY)){
				this.removeChild(super._start);
				super._start = null;
			}
			
			//splice
			
		}
		
		public function clicked(clickX:Number, clickY:Number):void{
			var currentTool:_editorObject = MovieClip(this.root).currentTool;
			
			if(currentTool._command == "devil"){
				
				var Devil = new _Devil;

				Devil.x = clickX;
				Devil.y = clickY;
				Devil.height *= 0.25;
				Devil.width *= 0.25;
				Devil.visible = true;
				
				this.addEnemy(Devil);
				
			}else if(currentTool._command == "trinket"){
				drawTrinket(clickX, clickY, 10);
			}else if(currentTool._command == "coin"){
				drawCheckpoint(clickX, clickY)
			}else if(currentTool._command == "platform"){
				
			}else if(currentTool._command == "bin"){
				this.removeObjectAtPoint(clickX, clickY);
			}else if(currentTool._command == "start"){
				drawStart(clickX, clickY);
			}else if(currentTool._command == "goal"){
				drawGoal(clickX,  clickY);
			}else if(currentTool._command == "noTool"){
				
			}
			
			/*
			devilIcon._tooltip = new _devilTooltip();
			devilIcon._command = "devil";
			
			coinIcon._tooltip = new coinTooltip();
			coinIcon._command = "coin";
			
			binIcon._tooltip = new _binTooltip();
			binIcon._command = "bin";
			
			platformIcon._tooltip = new _platformTooltip();
			platformIcon._command = "platform";
_			
			trinketIcon._tooltip = new _trinketTooltip();
			trinketIcon._command = "trinket";
			
			startIcon._tooltip = new _startTooltip();
			startIcon._command = "start";
			*/
		}
		
	}
	
}
