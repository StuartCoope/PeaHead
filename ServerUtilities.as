package  {
	import flash.events.Event;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	import flash.net.URLVariables;
	import flash.net.URLRequestMethod;
	import flash.net.URLLoaderDataFormat;
	
	public class ServerUtilities {

		public function ServerUtilities() {
			
		}
		
		public static function submitPlayData(levelID:int, timetaken:int, wins:int, losses:int){
			var request:URLRequest = new URLRequest ("submitWin.php");
			request.method = URLRequestMethod.POST;

			var postData:URLVariables = new URLVariables();
			postData.timeTaken = timetaken;
			postData.wins = wins;
			postData.losses = losses;
			postData.levelID = levelID;
			request.data = postData;

			//trace("REQUEST: " + request.data);
							
			var loader:URLLoader = new URLLoader (request);
			loader.addEventListener(Event.COMPLETE, onPlayDataComplete);
			loader.dataFormat = URLLoaderDataFormat.TEXT;
			loader.load(request);
		}
		
		public static function onPlayDataComplete(event:Event):void{
			trace("Result: " + event.target.data);
		}
		
		public static function submitLevelData(data:XML){
			var request:URLRequest = new URLRequest ("submitLevel.php");
			//var request:URLRequest = new URLRequest ("http://stuartcoope.kicks-ass.net/submitLevel.php");
			request.method = URLRequestMethod.POST;

			//trace("DATA: " + data);

			var postData:URLVariables = new URLVariables();
			postData.levelData = data.toString();
			postData.minTime = 0;
			request.data = postData;

			//trace("REQUEST: " + request.data);
							
			var loader:URLLoader = new URLLoader (request);
			loader.addEventListener(Event.COMPLETE, onComplete);
			loader.dataFormat = URLLoaderDataFormat.TEXT;
			loader.load(request);
		}
		
		public static function onComplete (event:Event):void{
			trace("RESULT: " + event.target.data );
		}
		
		

	}
	
}
