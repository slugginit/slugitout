package com.slugitout.tsapsa.screens
{
	import flash.events.EventDispatcher;
	import flash.media.SoundMixer;
	import flash.ui.Keyboard;
	
	import starling.display.BlendMode;
	import starling.display.Button;
	import starling.display.Image;
	import starling.display.Sprite;
	import starling.events.Event;
	import starling.events.KeyboardEvent;
	import starling.text.*;
	
	public class MenuScreen extends Sprite
	{
		/** Background image. */
		private var bg:Image;
		
		///** Game title. */
		//private var title:Image;
		
		/** Play button. */
		private var flag:Button;
		private var loaded:Boolean;
		
		public function MenuScreen()
		{
			super();
			this.visible = false;
			this.addEventListener(Event.ADDED_TO_STAGE, drawScreen);
		}
		public function initialize():void
		{
			disposeTemporarily();
			
			this.visible = true;
			flag.visible=true;
		}
		
		private function drawScreen():void{
			loaded = true;
			
			bg = new Image(Assets.getTexture("BgWelcome"));
			bg.blendMode = BlendMode.NONE;
			//bg.width=1280;
			//bg.height=740;
			this.addChild(bg);

			flag=new Button(Assets.getTexture("flag"));
			flag.x=400;
			flag.y=250;
			flag.addEventListener(Event.TRIGGERED, onPlayClick);
			this.addChild(flag);
		}
		
		private function onPlayClick(event:Event):void
		{
			this.dispatchEventWith("play",true);
		}
		public function disposeTemporarily():void
		{
			this.visible = false;
		}
	}
}