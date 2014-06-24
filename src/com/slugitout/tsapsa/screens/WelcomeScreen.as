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

package com.slugitout.tsapsa.screens
{
	
	import flash.events.EventDispatcher;
	import flash.media.SoundMixer;
	import flash.ui.Keyboard;
	
	import starling.display.BlendMode;
	import starling.display.Image;
	import starling.display.Sprite;
	import starling.events.Event;
	import starling.events.KeyboardEvent;
	
	import utilities.IntPoint;
	import utilities.Point;
	
	/**
	 * This is the welcome or main menu class for the game.
	 *  
	 * @author hsharma
	 * 
	 */
	public class WelcomeScreen extends Sprite
	{
		/** Background image. */
		private var bg:Image;
		
		private var screenMode:String;
		
		private var cameraAngle:Number = 0;
		private var loaded:Boolean = false;
		
		/** Game title. */
		//private var title:Image;
		
		/** Play button. */
		//private var playBtn:Button;
		
		/** About button. */
		//private var aboutBtn:Button;
		
		private var hero:Image;
		private var bucket:Image;
		
		private var suitcase:Suitcase = new Suitcase(new IntPoint(8, 5, 5));
		/*private var aboutText:TextField;
		private var hsharmaBtn:Button;
		private var starlingBtn:Button;
		private var backBtn:Button;
		private var screenMode:String;
		private var _currentDate:Date;
		private var fontRegular:Font;
		private var tween_hero:Tween;
		*/
		
		
		//cube
		private var cube:Array = new Array();
		
		private function initItems():void {
			var _dispatcher:EventDispatcher = new EventDispatcher();
			_dispatcher.addEventListener("Loaded", drawScreen);
			suitcase.addFirstItem("../templates/Noodle.txt", "noodle", _dispatcher);
			suitcase.addItemtoQueue("../templates/Cube1.txt", "noodle");
			suitcase.addItemtoQueue("../templates/Cube1.txt", "noodle");
			suitcase.addItemtoQueue("../templates/ComplexObj.txt", "noodle");
			
			suitcase.getQueueditem().addEventListener(Event.COMPLETE, drawScreen);
		}
		
		public function WelcomeScreen()
		{
			super();
			this.visible = false;
			initItems();
			this.addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
			
		}
		
		
		private function processInput(e: KeyboardEvent) : void {
			
			//wait until loaded
			if (!loaded) return;
			
			//x and z translation
			var transPoint:IntPoint = new IntPoint(0, 0, 0);
			var rotPoint:Point = new Point(0, 0, 0);
			var cameraRotation:Number = 0;
			
			if (e.keyCode == Keyboard.TAB)
				suitcase.cycleQueuedItem(1);
			
			if(e.keyCode == Keyboard.A)
				transPoint.x--;
			if (e.keyCode == Keyboard.D)
				transPoint.x++;
			if (e.keyCode == Keyboard.W)
				transPoint.z++;
			if (e.keyCode == Keyboard.S)
				transPoint.z--;
			
			//item rotation
			if (e.keyCode == Keyboard.NUMBER_1)
				rotPoint.x += Math.PI/2;
			if (e.keyCode == Keyboard.NUMBER_2)
				rotPoint.y -= Math.PI/2;
			if (e.keyCode == Keyboard.NUMBER_3)
				rotPoint.z += Math.PI/2;
			
			//camera rotation
			if (e.keyCode == Keyboard.Q)
				cameraRotation -= 1;
			if (e.keyCode == Keyboard.E)
				cameraRotation += 1;
			
			
			
			suitcase.moveItem(transPoint, rotPoint);
			suitcase.rotateCamera(cameraRotation);
			
			
			//place item
			if (e.keyCode == Keyboard.SPACE) {
				if (suitcase.placeItem()) {
					if (suitcase.done) {
						trace("You win");
					//TODO: check for end conditions
					}
				}
			}
			
			suitcase.drawSuitcase();

		}
		
		
		
		/**
		 * On added to stage. 
		 * @param event
		 * 
		 */
		private function onAddedToStage(event:Event):void
		{
			this.removeEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
			stage.addEventListener(KeyboardEvent.KEY_DOWN, processInput);
			
		}
		
		
		/**
		 * Draw all the screen elements. 
		 */
		private function drawScreen(e:flash.events.Event):void {
			// GENERAL ELEMENTS
			loaded = true;
			
			bg = new Image(Assets.getTexture("BgWelcome"));
			bg.blendMode = BlendMode.NONE;
			
			this.addChild(suitcase);
			
			
			bucket = new Image(Assets.getTexture("bucket"));
			bucket.x = 1000;
			bucket.y = 450;
			bucket.width = 256;
			bucket.height =256;
			this.addChild(bucket);
			
		}
			private function onAboutBackClick(event:Event):void
		{
			//if (!Sounds.muted) Sounds.sndCoffee.play();
			
			initialize();
		}
		
		
		/**
		 * On play button click. 
		 * @param event
		 * 
		 */
		/*private function onPlayClick(event:Event):void
		{
			this.dispatchEvent(new NavigationEvent(NavigationEvent.CHANGE_SCREEN, {id: "play"}, true));
			
			if (!Sounds.muted) Sounds.sndCoffee.play();
		}
		
		/**
		 * On about button click. 
		 * @param event
		 * 
		 */
		/*private function onAboutClick(event:Event):void
		{
			if (!Sounds.muted) Sounds.sndMushroom.play();
			showAbout();
		}
		
		/**
		 
		 * Show about screen. 
		 
		 * 
		 
		 */
		/*
		public function showAbout():void
			
		{
			
			screenMode = "about";
			
			hero.visible = false;
			playBtn.visible = false;
			aboutBtn.visible = false;
			
			aboutText.visible = true;
			hsharmaBtn.visible = true;
			starlingBtn.visible = true;
			backBtn.visible = true;
			
		}
		
		/**
		 * Initialize welcome screen. 
		 * 
		 */
		public function initialize():void
		{
			disposeTemporarily();
			
			this.visible = true;
			
			// If not coming from about, restart playing background music.
			/*if (screenMode != "about")
			{
				if (!Sounds.muted) Sounds.sndBgMain.play(0, 999);
			}*/
			
			screenMode = "welcome";
			
			/*hero.visible = true;
			playBtn.visible = true;
			aboutBtn.visible = true;
			
			aboutText.visible = false;
			hsharmaBtn.visible = false;
			starlingBtn.visible = false;
			backBtn.visible = false;
			
			hero.x = -hero.width;
			hero.y = 100;
			
			tween_hero = new Tween(hero, 4, Transitions.EASE_OUT);
			tween_hero.animate("x", 80);
			Starling.juggler.add(tween_hero);
			*/
			//this.addEventListener(Event.ENTER_FRAME, floatingAnimation);
		}
		
		/**
		 
		 * Animate floating objects. 
		 
		 * @param event
		 
		 * 
		 
		 */
		/*
		private function floatingAnimation(event:Event):void
			
		{
			_currentDate = new Date();
			
			hero.y = 130 + (Math.cos(_currentDate.getTime() * 0.002)) * 25;
			playBtn.y = 340 + (Math.cos(_currentDate.getTime() * 0.002)) * 10;
			aboutBtn.y = 460 + (Math.cos(_currentDate.getTime() * 0.002)) * 10;
		}
		
		/**
		 * Dispose objects temporarily. 
		 * 
		 */
		public function disposeTemporarily():void
		{
			this.visible = false;
			
			//if (this.hasEventListener(Event.ENTER_FRAME)) this.removeEventListener(Event.ENTER_FRAME, floatingAnimation);
			
			if (screenMode != "about") SoundMixer.stopAll();
		}
	}
}

