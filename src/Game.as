/**
 *
 * Hungry Hero Game
 * http://www.hungryherogame.com
 * 
 * Copyright (c) 2012 Hemanth Sharma (www.hsharma.com). All rights reserved.
 * 
 * This ActionScript source code is free.
 * You can redistribute and/or modify it in accordance with the
 * terms of the accompanying Simplified BSD License Agreement.
 *  
 */

package
{
	
	import com.slugitout.tsapsa.screens.GameScreen;
	import com.slugitout.tsapsa.screens.MenuScreen;
	import com.slugitout.tsapsa.screens.WelcomeScreen;
	
	import flash.media.SoundMixer;
	
	import starling.display.Sprite;
	import starling.events.Event;
	
	/**
	 * This class is the primary Starling Sprite based class
	 * that triggers the different screens. 
	 * 
	 * @author hsharma
	 * 
	 */
	public class Game extends Sprite
	{
		/** Screen - Welcome or Main Menu. */
		private var screenWelcome:WelcomeScreen;
		private var screenMenu:MenuScreen;
		
		private var gameScreen:GameScreen;
		
		
		/** Screen - InGame. */
		//private var screenInGame:InGame;
		
		/** Sound / Mute button. */
		//private var soundButton:SoundButton;
		
		public function Game()
		{
			super();
			
			this.addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
		}
		
		/**
		 * On Game class added to stage. 
		 * @param event
		 * 
		 */
		private function onAddedToStage(event:Event):void
		{
			this.removeEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
			
			// Initialize screens.
			initScreens();
		}

		
		private function initScreens():void
			
		{
			this.addEventListener("play",playScreen);
			//this.addEventListener(NavigationEvent.CHANGE_SCREEN, onChangeScreen);
			
			// InGame screen.
			//screenInGame = new InGame();
			//screenInGame.addEventListener(NavigationEvent.CHANGE_SCREEN, onInGameNavigation);
			//this.addChild(screenInGame);
			
			// Welcome screen.
			/*
			screenMenu = new MenuScreen();
			this.addChild(screenMenu);
			
			screenWelcome = new WelcomeScreen();
			this.addChild(screenWelcome);
			
			
			// Initialize the Welcome screen by default. 
			screenWelcome.initialize();*/
			
			gameScreen = new GameScreen();
			this.addChild(gameScreen);
			
		}
		
		private function playScreen():void
		{
					screenMenu.disposeTemporarily();
					screenWelcome.initialize();
		}
		/**
		 
		 * On navigation from different screens. 
		 
		 * @param event
		 
		 * 
		 
		 */
		/*
		private function onInGameNavigation(event:NavigationEvent):void
			
		{
			
			switch (event.params.id)
			{
				case "mainMenu":
					screenWelcome.initialize();
					break;
				case "about":
					screenWelcome.initialize();
					screenWelcome.showAbout();
					break;
			}
			
		}
		
		/**
		 
		 * On click of the sound/mute button. 
		 
		 * @param event
		 
		 * 
		 
		 */
		/*
		private function onSoundButtonClick(event:Event = null):void
			
		{
			
			if (Sounds.muted)
			{
				Sounds.muted = false;
				
				if (screenWelcome.visible) Sounds.sndBgMain.play(0, 999);
				else if (screenInGame.visible) Sounds.sndBgGame.play(0, 999);
				
				soundButton.showUnmuteState();
			}
			else
			{
				Sounds.muted = true;
				SoundMixer.stopAll();
				
				soundButton.showMuteState();
			}
			
		}
		
		/**
		 
		 * On change of screen. 
		 
		 * @param event
		 
		 * 
		 
		 */
		/*
		private function onChangeScreen(event:NavigationEvent):void
			
		{
			
			switch (event.params.id)
			{
				case "play":
					screenWelcome.disposeTemporarily();
					screenInGame.initialize();
					break;
			}
			
		}*/
	}
}// ActionScript file