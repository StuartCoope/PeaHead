package  {
	import flash.events.Event;
	import flash.net.URLRequest;
	import flash.net.URLLoader;
	import flash.net.URLRequestMethod;
	import flash.net.URLLoaderDataFormat;
	import flash.errors.IOError;
	
	public class PeaFacade {

		public static var currentLevel:_LevelData;
		public static var levels:Array;
		public static var customLevelPending:Boolean;
		
		public function PeaFacade() {
			customLevelPending=false;
		}
		
		public static function getLevel():_LevelData{
			return currentLevel;
		}
		
		public static function setLevel(level:_LevelData):void{
			currentLevel = level;
		}
		
		public static function setCustomLevel(levelID:int):void{
			
			var query:String = "getLevelData.php?levelID="+levelID;
			var request:URLRequest = new URLRequest(query);
			request.method = URLRequestMethod.GET;
			
			var loader:URLLoader = new URLLoader (request);
			loader.addEventListener(Event.COMPLETE, onComplete);
			loader.dataFormat = URLLoaderDataFormat.TEXT;
			
			try{
				loader.load(request);
			}catch(e:IOError){
				trace("Error: "+e.message);
			}
			
			customLevelPending = true;
		}

		private static function onComplete (event:Event):void{
			
			currentLevel = new _LevelData();
			
			
			customLevelPending = false;
			var xmlString:String = event.target.data;

			trace("RESULT: \n" + xmlString );

			var customData:XML = new XML(xmlString);
			//trace("XML Object: \n" + customData);
			var customLevel:_CustomLevelData = new _CustomLevelData();
			
			customLevel.levelID = customData.levelID;
			customLevel.userID = customData.userID;
			customLevel.userName = customData.username;
			customLevel.bestTime = customData.bestTime;
			customLevel.difficulty = customData.difficulty;
			
			
			//currentLevel.level = new _Level(new XML(customData.level) );
			currentLevel.level = new _Level(new XML( customData.level.toString() ) );
			//trace(currentLevel.level.serializeLevel().toString());
			currentLevel.customData = customLevel;
			currentLevel.isTest = false;
		}
		
		public static function pushLevel(level:_LevelData):void{
			if(levels == null){
				levels = new Array();
			}
			
			levels.push(level);
			trace(levels);
		}
		
		public static function getLevelData(i:int):_LevelData{
			return levels[i];
		}
		
	}
}
