package  {
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.geom.Point;
	import flash.xml.XMLNode;
	
	public class _Level extends Sprite{
		public var _platforms:Vector.<MovieClip>;
		public var _enemies:Vector.<_Enemy>;
		public var _checkPoints:Vector.<_CheckCoin>;
		public var _trinkets:Vector.<_Trinket>;
		public var _goal:_Goal;
		public var _start:_Start;
		public var _isTest:Boolean;

		public function _Level(data:XML = null) {
			
			_isTest = true;
			
			_platforms = new Vector.<MovieClip>;
			_enemies = new Vector.<_Enemy>;
			_checkPoints = new Vector.<_CheckCoin>;
			_trinkets = new Vector.<_Trinket>;
			//_goal = new _Goal();
			
			if(data != null){
				populateLevel(data);
			}
			
		}
		
		public function setTest(testMode:Boolean){
			_isTest = testMode;
		}
		
		public function populateLevel(levelData:XML){
			/*_platforms = new Vector.<MovieClip>;
			_enemies = new Vector.<_Enemy>;
			_checkPoints = new Vector.<_CheckCoin>;
			_trinkets = new Vector.<_Trinket>;
			*/
			var platformList:XMLList = levelData.platforms;

			for each (var platformInfo:XML in platformList) {
				for each (var platform:XML in platformInfo.children() ){
					
					var p:BeanCan = new BeanCan();
					
					p.x = platform.attribute("x");
					p.y = platform.attribute("y");
					p.width = platform.attribute("width");
					p.height = platform.attribute("height");
					
					_platforms.push(p);
					this.addChild(p);
				}
			}

			var enemyList:XMLList = levelData.enemies;
			for each (var enemyInfo:XML in enemyList) {
				for each (var enemy:XML in enemyInfo.children() ){
					
					var Devil = new _Devil;

					Devil.x = enemy.attribute("x");
					Devil.y = enemy.attribute("y");
					Devil.height *= 0.25;
					Devil.width *= 0.25;
					Devil.visible = true;
					
					this.addEnemy(Devil);
				}
			}
			
			var checkpointList:XMLList = levelData.checkpoints;
			for each (var checkpointInfo:XML in checkpointList) {
				for each (var checkpoint:XML in checkpointInfo.children() ){
					drawCheckpoint( checkpoint.attribute("x"), checkpoint.attribute("y") );
				}
			}
			
			var trinketList:XMLList = levelData.trinkets;
			for each (var trinketInfo:XML in trinketList) {
				for each (var trinket:XML in trinketInfo.children() ){
					drawTrinket( trinket.attribute("x"), trinket.attribute("y"), trinket.attribute("value")  );
				}
			}

			var startInfo:XML = levelData.start[0];
			if(startInfo != null){
				drawStart( startInfo.attribute("x"), startInfo.attribute("y") );
			}
			
			var goalInfo:XML = levelData.goal[0];
			if(goalInfo != null){
				drawGoal( goalInfo.attribute("x"), goalInfo.attribute("y") );
			}
			
			//trace( levelData.descendants("platform").attribute("x") );
			//trace( levelData. );			
		}
		
		public function serializeLevel():XML{
			
			var output:String = "";
			output += "<level>";
			output += "<platforms>";
			
			for(var i:Number = 0; i < _platforms.length; i++){
				output += "<platform x = \""+_platforms[i].x + "\" y=\"" + _platforms[i].y + "\" width=\"" + _platforms[i].width + "\" height=\"" + _platforms[i].height + "\"/>";
			}
			
			output += "</platforms>";
			
			output += "<enemies>";
			
			for(var i:Number = 0; i < _enemies.length; i++){
				output += "<enemy x = \""+_enemies[i].x + "\" y=\"" + _enemies[i].y + "\" width=\"" + _enemies[i].width + "\" height=\"" + _enemies[i].height + "\"/>";
			}
			
			output += "</enemies>";
			
			output += "<checkpoints>";
			
			for(var i:Number = 0; i < _checkPoints.length; i++){
				output += "<checkpoint x = \""+_checkPoints[i].x + "\" y=\"" + _checkPoints[i].y+ "\"/>";
			}
			
			output += "</checkpoints>";
			
			output += "<trinkets>";
			
			for(var i:Number = 0; i < _trinkets.length; i++){
				output += "<trinket x = \""+_trinkets[i].x + "\" y=\"" + _trinkets[i].y+ "\" value=\"" + _trinkets[i].value + "\"/>";
			}
			
			output += "</trinkets>";
			
			if(_goal != null){
				output += "<goal x = \""+_goal.x+"\" y=\""+_goal.y+"\"/>";
			}
			
			if(_start != null){
				output += "<start x = \""+_start.x+"\" y=\""+_start.y+"\"/>";
			}
			
			output += "</level>";
			
			var xmlOut:XML = new XML(output);
			
			//trace("~~~~~~~SL Output~~~~~\n"+xmlOut+"\n~~~~~~~~~~~~~~~~\n");
			
			return xmlOut;
		}
		
		public function addEnemy(e:_Enemy){
			_enemies.push(e);
			this.addChild(e);
		}

		public function drawCheckpoint(x:int, y:int){
			
			var checkPoint:_CheckCoin = new CheckCoin();
			checkPoint.x = x;
			checkPoint.y = y;
			
			_checkPoints.push(checkPoint);
			this.addChild(checkPoint);
		}
		
		public function drawStart(x:int, y:int){
			if(this._start != null){
				this.removeChild(this._start);
				this._start = null;
			}
			
			//draw a start symbol as we're calling this from the level editor.
			var startP:_Start = new _Start();
			
			startP.x = x;
			startP.y = y;
			
			_start = startP;
			this.addChild(_start);
		}
		
		public function drawGoal(x:int, y:int){
			
			if(this._goal != null){
				this.removeChild(this._goal);
				this._goal = null;
			}
			
			var goal:_Goal = new Goal();
			
			goal.x = x;
			goal.y = y;
			
			_goal = goal;
			this.addChild(goal);
		}
		
		public function drawTrinket(x:int, y:int, value:int){
			//pick a random trinket to draw!
			var randomNo:Number = Math.floor(Math.random()*3);
			var trinket:_Trinket;
			
			if(randomNo==0){
				trinket = new Star();
			}else if(randomNo ==1){
				trinket = new Clover();
			}else if(randomNo ==2){
				trinket = new Rainbow();
			}
			
			trinket.value = value;
			trinket.x = x;
			trinket.y = y;
			
			_trinkets.push(trinket);
			this.addChild(trinket);
			
		}

		public function drawPlatform(x:int, y:int, width:int, height:int){
			//could be drawing either a ledge-like platform, or a tower-like.
			
			/*
				1. find nice number of tiles to go vertically. and what height they should be.
					(right to 10px?)
			*/
			
			//because we're too lazy to think backwards, we will just invert co-ordinates to deal with drawing
			//anywhere with negative width or height.
			
			if(width < 0){
				x += width;
				width = -width;
			}
			
			if(height < 0){
				y += height;
				height = -height;
			}

			var pilot:BeanCan = new BeanCan();
			var verticalPieces:Number = 1;
			

			while(true){				
				//work out a ratio to satisfy vertical requirement
				var ratio:Number = (height / verticalPieces) / pilot.height ;
				pilot.width *= ratio;
				pilot.height *= ratio;

				//work out how many to go horizontally.
				var horizontalPieces:Number = 0;

				while( Math.abs( width - ( (horizontalPieces+1) * pilot.width)) < Math.abs( width - ( horizontalPieces * pilot.width) ) ){
					horizontalPieces++;
				}
				
				//see if the match is acceptable
				if(Math.abs(width - (pilot.width * horizontalPieces) ) < 20)
				{
					//if so, draw the grid of horizontalPieces by verticalPieces at size*=ratio.
					for(var i:Number = 0; i < horizontalPieces; i++)
					{
						for(var j:Number = 0; j < verticalPieces; j++)
						{
							var platform:BeanCan = new BeanCan();
							
							platform.width = pilot.width;
							platform.height = pilot.height;
							
							platform.x = x + (i * platform.width);
							platform.y = y + (j * platform.height);
							
							_platforms.push(platform);
							this.addChild(platform);
						}
					}
					
					break;
				}
			
				verticalPieces++;
			
				if(verticalPieces > 200){
					//Safety!
					trace("Too many vertical pieces!");
					break;
				}
			}

	
			/*
			var pilot:BeanCan = new BeanCan();
			
			//work out how many pieces wide we are
			var ratio:Number = height / pilot.height;
			var cans = Math.floor(width / ((pilot.width*ratio)-1));
			
			//trace("Ratio: " + ratio + ", Platform width: " + pilot.width*ratio);
			//trace(cans + " cans needed.");
		
			for(var i:Number = 0; i < cans; i++)
			{
				var platform:BeanCan = new BeanCan();
				
				platform.width *= ratio;
				platform.height *= ratio;
				
				platform.y = y;
				platform.x = x+(i*platform.width)-(i*cans);
				
				_platforms.push(platform);
				this.addChild(platform);		
			}*/
		}
	}	
}
