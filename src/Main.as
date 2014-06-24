package
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Loader;
	import flash.display.LoaderInfo;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.net.URLRequest;
	
	import starling.core.Starling;
	
	[SWF(frameRate="60", width="1024", height="768", backgroundColor="0x000000")]
	
	public class Main extends Sprite {		
		/** Starling object. */
		private var myStarling:Starling;
		
		public function Main() {		
			this.addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
		}
		
		/**
		 * On added to stage. 
		 * @param event
		 * 
		 */
		protected function onAddedToStage(event:Event):void
		{
			this.removeEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
			
			// Initialize Starling object.
			myStarling = new Starling(Game, stage);
			
			// Define basic anti aliasing.
			myStarling.antiAliasing = 1;
			
			// Show statistics for memory usage and fps.
			myStarling.showStats = true;
			
			// Position stats.
			myStarling.showStatsAt("left", "bottom");
			
			// Start Starling Framework.
			myStarling.start();
		}
	}
}