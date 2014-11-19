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
	
	import display.DisplayQueue;
	
	import flash.events.EventDispatcher;
	import flash.media.SoundMixer;
	import flash.ui.Keyboard;
	
	import starling.display.BlendMode;
	import starling.display.Button;
	import starling.display.Image;
	import starling.display.Sprite;
	import starling.events.Event;
	import starling.events.KeyboardEvent;
	import starling.utils.Color;
	
	import utilities.IntPoint;
	import utilities.Point;
	import utilities.SuitcaseBuilder;
	
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
		

		/** About button. */
		//private var aboutBtn:Button;
		
		private var hero:Image;
		private var bucket:Image;
		private var belt:Image;
		private var scoreimage:Image;
		
		private var suitcase:Suitcase = new Suitcase(new IntPoint(8, 5, 5));
		private var builder:SuitcaseBuilder;
		
		private function initItems(e:flash.events.Event):void {
			var suitcaseItems:Vector.<Item> = builder.constructSuitcase(new IntPoint(5, 5, 5));
			for (var i:int = 0; i < suitcaseItems.length; i++) {
				suitcase.addLoadedItemToQueue(suitcaseItems[i]);
			}
			drawScreen();
		}
		
		private function initSuitcaseBuilder():void {
			var _dispatcher:EventDispatcher = new EventDispatcher();

			_dispatcher.addEventListener("BuilderLoaded", initItems);
			builder = new SuitcaseBuilder(_dispatcher);
			
			//builder.addEventListener(Event.COMPLETE, drawScreen);
			

			//suitcase.addFirstItem("../templates/Noodle.txt", "noodle", _dispatcher);
			//suitcase.addItemtoQueue("../templates/Cube1.txt", "sock");
			//suitcase.addItemtoQueue("../templates/Cube1.txt", "sock");
			//suitcase.addItemtoQueue("../templates/Noodle.txt", "noodle");

			//suitcase.addFirstItem("../templates/camera.txt", "camera", _dispatcher);
			/*suitcase.addItemtoQueue("../templates/boot.txt", "boot");
			suitcase.addItemtoQueue("../templates/bottle.txt", "bottle");


			suitcase.addItemtoQueue("../templates/money.txt", "money");*/

		}
		
		
		
		public function WelcomeScreen()
		{
			super();
			this.visible = false;
			initSuitcaseBuilder();
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
			if (e.keyCode == Keyboard.Q){
				cameraRotation -= 1;
				suitcase.rotateCamera(cameraRotation);
			}
			if (e.keyCode == Keyboard.E){
				cameraRotation += 1;
				suitcase.rotateCamera(cameraRotation);
			}
			

			suitcase.moveItem(transPoint, rotPoint);
			
			
			//place item
			if (e.keyCode == Keyboard.SPACE) {
				if (suitcase.placeItem()) {
					if (suitcase.done) {
						trace("You win");
					//TODO: check for end conditions
					}
				}
			}
			
			trace("Redrawing screen");
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
		private function drawScreen():void {
			trace("First screen draw");
			// GENERAL ELEMENTS
			loaded = true;
			
			//bg = new Image(Assets.getTexture("BgWelcome2"));
			//bg.blendMode = BlendMode.NONE;
			//bg.width=1280;
			//bg.height=740;
			//this.addChild(bg);

			this.addChild(suitcase);
			suitcase.moveItem(new IntPoint(0, 0, 0),new Point(0, 0, 0));
			suitcase.rotateCamera(0);
			suitcase.drawSuitcase();
			
			
			
			
			//draw the item swap bucket
			bucket = new Image(Assets.getTexture("bucket"));
			bucket.x = 0;
			bucket.y = 500;
			bucket.width = 256;
			bucket.height =256;
			this.addChild(bucket);
			
			//draw the belt
			belt = new Image(Assets.getTexture("belt"));
			belt.x = 0;
			belt.y = 0;
			belt.width = 256;
			belt.height = 500;
			this.addChild(belt);
			
			scoreimage = new Image(Assets.getTexture("scoreimage"));
			scoreimage.x = 1050;
			scoreimage.y = 0;
			scoreimage.width = 64;
			scoreimage.height = 64;
			this.addChild(scoreimage);
			
			
		}
			private function onAboutBackClick(event:Event):void
		{
			initialize();
		}
		
		
		/**
		 * Initialize welcome screen. 
		 * 
		 */
		public function initialize():void
		{
			disposeTemporarily();
			
			this.visible = true;
			if(suitcase.saved()){
				suitcase.Loadone();
			}
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

