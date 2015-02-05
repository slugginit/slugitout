package com.slugitout.tsapsa.screens
{
	import flash.events.EventDispatcher;
	
	import starling.display.Sprite;
	import starling.events.Event;
	import starling.events.KeyboardEvent;
	
	import utilities.IntPoint;
	import utilities.Point;
	import utilities.SuitcaseBuilder;
	
	public class GameScreen extends Sprite {
		
		/**
		 * 1. Open game (Display splash screen)
		 * 2. Load or New Game (Main Menu)
		 * 3. New Game - create level with difficulty settings
		 * 4. Load Game - select slot to load
		 * 5. Transition to main game mode
		 * 6. Check for end condition - load next level
		 * 7. Pause - open menu - Save and Quit, Resign, Reset
		 * */
		
		//game state
		private var MAIN_MENU = 0;
		private var GAME = 1;
		private var PAUSE = 2;
		private var GAME_OVER = 3;
		
		private var gameState = MAIN_MENU;
		private var menu:MainMenu;
		private var gameOverScreen:GameOverScreen;
		private var pauseScreen:PauseScreen;
		
		//camera variables
		private var cameraAngle:Number = 0;
		
		//event variables
		private var dispatcher:EventDispatcher = new EventDispatcher();
		
		//suitcase builder
		private var suitcaseBuilder:SuitcaseBuilder;
		
		//current suitcase
		private var suitcase:Suitcase;
		
		//suitcase quota
		private var suitaseQuota;
		
		
		public function GameScreen() {
			super();
			this.addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
			suitcaseBuilder = new SuitcaseBuilder(dispatcher);
		}
		
		
		
		private function processInput(e:KeyboardEvent):void {
			var returnAction:int = null;
			
			/** process input */
			if (gameState == MAIN_MENU)
				returnAction = menu.processInput(e);
			else if (gameState == GAME)
				returnAction = suitcase.processInput(e);
				
				
			/**check return for action that needs to be taken*/
			//start new game - switch state to loading
			if (returnAction == Constant.EASY_GAME || returnAction == Constant.NORMAL_GAME || returnAction == Constant.HARD_GAME) {
				//build an easy suitcase, draw loading screen, switch state to game
				createSuitcase(returnAction, null);
				gameState = GAME;
			}
			//load existing game - switch state to loading
			//TODO:
			//end condition - switch state to game over
			else if (suitcase != null && returnAction == Constant.VICTORY) {
				gameState = GAME_OVER;
			}
			
			/** draw screen */
			drawScreen();
			
		}
		
		private function drawScreen() {
			this.removeChildren(0, this.numChildren);
			
			if (gameState == MAIN_MENU) {
				this.addChild(menu);	
				menu.drawMenu();
			}
			if (gameState == GAME) {
				this.addChild(suitcase);
				suitcase.drawSuitcase();
			}
			if (gameState == GAME_OVER) {
				this.addChild(gameOverScreen);
				gameOverScreen.drawScreen();
			}
		}
		
		private function createSuitcase(difficulty:int, swapItem:Item):void {
			//todo - determine suitcase size based on difficulty
			var suitcaseItems:Vector.<Item> = suitcaseBuilder.constructSuitcase(new IntPoint(3, 3, 3));
			suitcase = new Suitcase(new IntPoint(8, 5, 5), swapItem);
			for (var i:int = 0; i < suitcaseItems.length; i++) {
				suitcase.addLoadedItemToQueue(suitcaseItems[i]);
			}
			
			if(suitcase.getQueueditem().initialized) {
				suitcase.loaded = true;
				suitcase.moveItem(new IntPoint(0, 0, 0),new Point(0, 0, 0));
				suitcase.rotateCamera(0);
				drawScreen();
			}
			else {
				dispatcher.addEventListener("Loaded", drawScreenEvent);
			}
		}
		
		//first suitcase screen draw
		private function drawScreenEvent(e:flash.events.Event):void {
			trace("Drawing screen from Loaded event");
			dispatcher.removeEventListener("Loaded", drawScreenEvent);
			suitcase.loaded = true;
			suitcase.moveItem(new IntPoint(0, 0, 0),new Point(0, 0, 0));
			suitcase.rotateCamera(0);
			drawScreen();
		}
		
		
		private function onAddedToStage(event:Event):void{
			menu = new MainMenu();
			gameOverScreen = new GameOverScreen();
			this.removeEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
			stage.addEventListener(KeyboardEvent.KEY_DOWN, processInput);
			this.addChild(menu);
			menu.drawMenu();
		}
		
	}
}