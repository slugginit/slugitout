package com.slugitout.tsapsa.screens {
	import flash.ui.Keyboard;
	
	import starling.display.Image;
	import starling.display.Sprite;
	import starling.events.KeyboardEvent;
	
	public class GameOverScreen extends Sprite {
		private var gameOverBackground:Image;
				
		private var signals: Array = new Array(Constant.NEXT_LEVEL, Constant.RETIRE);
		
		private var RESTART = 0;
		private var QUIT = 1;
		
		private var selectionIndex:int = RESTART;
		
		public function LoadingScreen() {
			gameOverBackground = new Image(Assets.getTexture("gameOverBackground"));
		}
		
		public function drawScreen() {
			gameOverBackground.x = stage.stageWidth/2 - gameOverBackground.width/2;
			gameOverBackground.y = stage.stageHeight/2 - gameOverBackground.height/2;
		}
		
		private function cycleSelection(direction:int):void {
			selectionIndex = (selectionIndex + direction)%signals.length;
		}
		
		public function processInput(e:KeyboardEvent):String {
			var returnOption:String = null;
			
			if (e.keyCode == Keyboard.DOWN || e.keyCode == Keyboard.S)
				cycleSelection(1);
			if (e.keyCode == Keyboard.UP || e.keyCode == Keyboard.W)
				cycleSelection(-1);
			
			if (e.keyCode == Keyboard.SPACE || e.keyCode == Keyboard.ENTER)
				returnOption = signals[selectionIndex];
			
			return returnOption;
		}
	}
	
}