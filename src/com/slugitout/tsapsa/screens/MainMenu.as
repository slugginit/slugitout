package com.slugitout.tsapsa.screens {
	
	import flash.geom.Rectangle;
	import flash.ui.Keyboard;
	
	import flashx.textLayout.formats.Float;
	
	import starling.core.Starling;
	import starling.core.starling_internal;
	import starling.display.Image;
	import starling.display.Quad;
	import starling.display.Sprite;
	import starling.display.Stage;
	import starling.events.KeyboardEvent;
	import starling.text.TextField;
	import starling.utils.Color;
	import starling.events.Event;
	
	public class MainMenu extends Sprite {
		//buttons per menu state
		private var options:Array = new Array(4, 2, 1, 4);
		
		//commands to return to main
		public var EASY_GAME = "easy-game";
		public var NORMAL_GAME = "normal-game";
		public var HARD_GAME = "hard-game";
		
		//possible menu states
		private var NEW_GAME = 0;
		private var LOAD_GAME = 1;
		private var CREDITS = 2;
		private var MENU = 3;
		//current menu state
		public var currentState = MENU;
		public var selectionIndex = 0;
		
		private var background:Image;
		private var button:Image;
		
		public function MainMenu() {
			super();
			//load images
			background = new Image(Assets.getTexture("menuBackground"));
		}
		
		
		
		private function cycleSelection(direction:int):void {
			selectionIndex = (selectionIndex + direction + options[currentState])%options[currentState];
		}
		
		/**
		 * User pressed enter - selection option based on context.
		 * */
		private function selectOption():String {
			var returnOption:String = null;
			if (currentState == MENU) {
				if (selectionIndex == 0)
					currentState = NEW_GAME;
				else if (selectionIndex == 1)
					currentState = LOAD_GAME;
				else if (selectionIndex == 2)
					currentState = CREDITS;
				else if (selectionIndex == 3) {
					trace("Trying to close game");
					Starling.current.dispatchEventWith(Main.EVT_CLOSEAPP);	
				}
			}
			else if (currentState == NEW_GAME) {
				if (selectionIndex == 0)
					returnOption = EASY_GAME;
				else if (selectionIndex == 1)
					returnOption = NORMAL_GAME;
				else if (selectionIndex == 2)
					returnOption = HARD_GAME;
				else
					currentState = MENU;
			}
			else if (currentState == LOAD_GAME) {
				//todo: list save slots that have games in them
				currentState = MENU;
			}
			else if (currentState = CREDITS) {
				currentState = MENU;
			}
			
			selectionIndex = 0;
			return returnOption;
			
		}
		
		public function processInput(e:KeyboardEvent):String {
			if (e.keyCode == Keyboard.DOWN || e.keyCode == Keyboard.S) {
				cycleSelection(1);
			}
			if (e.keyCode == Keyboard.UP || e.keyCode == Keyboard.W) {
				cycleSelection(-1);
			}
			if (e.keyCode == Keyboard.SPACE || e.keyCode == Keyboard.ENTER) {
				return selectOption();
			}
			
			return null;
		}
		
		public function drawMenu() : void {
			this.removeChildren(0, this.numChildren);
			background.x = stage.stageWidth/2 - background.width/2;
			background.y = stage.stageHeight/2 - background.height/2;
			this.addChild(background);
			var buttonOffset:int = 115;
			
			var xOffset = stage.stageWidth/2 - 100;
			var yOffset = stage.stageHeight/2 - background.height/2 + 25;
			
			for (var i:int = 0; i < options[currentState]; i++) {
				var buttonClone:Image = new Image(Assets.getTexture("button"));
				buttonClone.x = xOffset;
				buttonClone.y = yOffset + i*buttonOffset;
				this.addChild(buttonClone);
			}
			
			//draw selection box
			var selectionQuad:Quad = new Quad(200, 100, Color.YELLOW);
			selectionQuad.x = xOffset;
			selectionQuad.y = yOffset + selectionIndex*buttonOffset;
			this.addChild(selectionQuad);
			
			var counter:int = 0;
			if (currentState == MENU) {
				//new game button
				var newGame:TextField = new TextField(200, 100, "NEW GAME", "Arial", 36, Color.RED);
				newGame.x = xOffset;
				newGame.y = yOffset + buttonOffset*counter++;
				this.addChild(newGame);
				
				//load game button
				var loadGame:TextField = new TextField(200, 100, "LOAD GAME", "Arial", 36, Color.RED);
				loadGame.x = xOffset;
				loadGame.y = yOffset + buttonOffset*counter++;
				this.addChild(loadGame);
				
				//credits button
				var credits:TextField = new TextField(200, 100, "CREDITS", "Arial", 36, Color.RED);
				credits.x = xOffset;
				credits.y = yOffset + buttonOffset*counter++;
				this.addChild(credits);
				
				//quit button
				var quit:TextField = new TextField(200, 100, "QUIT GAME", "Arial", 36, Color.RED);
				quit.x = xOffset;
				quit.y = yOffset + buttonOffset*counter++;
				this.addChild(quit);
			}
			else if (currentState == NEW_GAME) {
				//difficulty
				var easy:TextField = new TextField(200, 100, "EASY", "Arial", 36, Color.RED);
				easy.x = xOffset;
				easy.y = yOffset + buttonOffset*counter++;
				this.addChild(easy);
				
				var medium:TextField = new TextField(200, 100, "MEDIUM", "Arial", 36, Color.RED);
				medium.x = xOffset;
				medium.y = yOffset + buttonOffset*counter++;
				this.addChild(medium);
				
				var hard:TextField = new TextField(200, 100, "HARD", "Arial", 36, Color.RED);
				hard.x = xOffset;
				hard.y = yOffset + buttonOffset*counter++;
				this.addChild(hard);
				
				//back button
				var back:TextField = new TextField(200, 100, "BACK", "Arial", 36, Color.RED);
				back.x = xOffset;
				back.y = yOffset + buttonOffset*counter++;
				this.addChild(back);
			}
			else if (currentState == LOAD_GAME) {
				//game slots to load from
				
				//back button
				var back:TextField = new TextField(200, 100, "BACK", "Arial", 36, Color.RED);
				back.x = xOffset;
				back.y = yOffset + buttonOffset*counter++;
				this.addChild(back);
			}
			else if (currentState == CREDITS) {
				//credits
				
				//back button
				var back:TextField = new TextField(200, 100, "BACK", "Arial", 36, Color.RED);
				back.x = xOffset;
				back.y = yOffset + buttonOffset*counter++;
				this.addChild(back);
			}
			
			
		}
		
		
	}
}