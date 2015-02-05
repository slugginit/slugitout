package com.slugitout.tsapsa.screens {
	
	import flash.ui.Keyboard;
	
	import starling.display.Image;
	import starling.display.Quad;
	import starling.display.Sprite;
	import starling.events.KeyboardEvent;
	import starling.utils.Color;
	import starling.text.TextField;
	
	public class PauseScreen extends Sprite {
		private var pauseBackground:Image;
		private var button:Image;
		
		//possible menu states
		public var RESUME = 0;
		public var SAVE_QUIT = 1;
		public var RESTART = 2;
		public var RETIRE = 3;
		
		//return states
		private var signals: Array = new Array(Constant.RESUME, Constant.SAVE_QUIT, Constant.RESTART, Constant.RETIRE);
		
		
		//current menu state
		public var currentState = RESUME;
		
		public function PauseScreen() {
			pauseBackground = new Image(Assets.getTexture("pauseBackground"));
		}
		
		public function drawPauseScreen() {
			this.removeChildren(0, this.numChildren);
			pauseBackground.x = stage.stageWidth/2 - pauseBackground.width/2;
			pauseBackground.y = stage.stageHeight/2 - pauseBackground.height/2;
			this.addChild(pauseBackground);
			
			
			//draw buttons
			var buttonOffset:int = 115;
			
			var xOffset = stage.stageWidth/2 - 100;
			var yOffset = stage.stageHeight/2 - pauseBackground.height/2 + 25;
			
			for (var i:int = 0; i < 4; i++) {
				var buttonClone:Image = new Image(Assets.getTexture("button"));
				buttonClone.x = xOffset;
				buttonClone.y = yOffset + i*buttonOffset;
				this.addChild(buttonClone);
			}
			
			//draw selection box
			var selectionQuad:Quad = new Quad(200, 100, Color.YELLOW);
			selectionQuad.x = xOffset;
			selectionQuad.y = yOffset + currentState*buttonOffset;
			this.addChild(selectionQuad);
			
			var counter:int = 0;
			
			//resume
			var resume:TextField = new TextField(200, 100, "RESUME", "Arial", 36, Color.RED);
			resume.x = xOffset;
			resume.y = yOffset + buttonOffset + counter++;
			this.addChild(resume);
			
			//save and quit
			var savequit:TextField = new TextField(200, 100, "SAVE AND QUIT", "Arial", 36, Color.RED);
			savequit.x = xOffset;
			savequit.y = yOffset + buttonOffset + counter++;
			this.addChild(savequit);
			
			//restart
			var restart:TextField = new TextField(200, 100, "RESTART", "Arial", 36, Color.RED);
			restart.x = xOffset;
			restart.y = yOffset + buttonOffset + counter++;
			this.addChild(restart);
			
			//retire
			var retire:TextField = new TextField(200, 100, "RETIRE", "Arial", 36, Color.RED);
			retire.x = xOffset;
			retire.y = yOffset + buttonOffset + counter++;
			this.addChild(retire);
		}
		
		private function cycleSelection(direction:int):void {
			currentState = (currentState + direction + 4)%4;
		}
		
		public function processInput(e:KeyboardEvent):int {
			if (e.keyCode == Keyboard.DOWN || e.keyCode == Keyboard.S)
				cycleSelection(1);
			if (e.keyCode == Keyboard.UP || e.keyCode == Keyboard.W)
				cycleSelection(-1);
			if (e.keyCode == Keyboard.SPACE || e.keyCode == Keyboard.ENTER)
				return signals[currentState];
			
			//no selection
			return Constant.NO_ACTION;
		}
	}
}