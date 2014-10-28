package com.slugitout.tsapsa.screens
{
	import flash.events.EventDispatcher;
	import flash.media.SoundMixer;
	import flash.ui.Keyboard;
	import flash.desktop.NativeApplication;
	import flash.net.SharedObject;
	
	import starling.display.BlendMode;
	import starling.display.Button;
	import starling.display.Image;
	import starling.display.Sprite;
	import starling.events.Event;
	import starling.events.KeyboardEvent;
	import starling.text.TextField;
	import starling.utils.HAlign;
	import starling.utils.VAlign;
	
	import utilities.Save;
	
	public class MenuScreen extends Sprite
	{
		/** Background image. */
		private var bg:Image;
		
		///** Game title. */
		//private var title:Image;
		
		private var helpMsg:TextField;
		/** Play button. */
		private var playBtn:Button;
		private var contBtn:Button;
		private var quitBtn:Button;
		private var helpBtn:Button;
		private var backBtn:Button;
		
		private var loaded:Boolean;
		private var saveFile:SharedObject=SharedObject.getLocal("save1");
		
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
			playBtn.visible=true;
			contBtn.visible=true;
			helpBtn.visible=true;
			quitBtn.visible=true;
			backBtn.visible=false;
			helpMsg.visible=false;
			
		}
		
		private function drawScreen():void{
			loaded = true;
			
			bg = new Image(Assets.getTexture("BgWelcome"));
			bg.blendMode = BlendMode.NONE;
			//bg.width=1280;
			//bg.height=740;
			this.addChild(bg);

			//new game
			playBtn=new Button(Assets.getTexture("play"));
			playBtn.x=400;
			playBtn.y=150;
			playBtn.addEventListener(Event.TRIGGERED, onPlayClick);
			this.addChild(playBtn);
			//continue
			contBtn=new Button(Assets.getTexture("cont"));
			contBtn.x=400;
			contBtn.y=300;
			contBtn.addEventListener(Event.TRIGGERED, onContClick);
			this.addChild(contBtn);
			//push for helpmsg
			helpBtn=new Button(Assets.getTexture("helpbtn"));
			helpBtn.x=400;
			helpBtn.y=450;
			helpBtn.addEventListener(Event.TRIGGERED, onHelpClick);
			this.addChild(helpBtn);
			//helpmsg on controls
			helpMsg= new TextField(650, 200,"","Arial", 26, 0x000000);
			helpMsg.text="Move the items around with wasd and place with space.\n"+
				"Use 1234 to rotate your item in different orientations.\n"+
				"Fit all of the items back into your suitcase to proceed.\n";
			helpMsg.x=350;
			helpMsg.y=300;
			helpMsg.hAlign = HAlign.CENTER;
			helpMsg.vAlign = VAlign.CENTER;
			this.addChild(helpMsg);
			//push to quit
			quitBtn=new Button(Assets.getTexture("quitbtn"));
			quitBtn.x=400;
			quitBtn.y=600;
			quitBtn.addEventListener(Event.TRIGGERED, onQuitClick);
			this.addChild(quitBtn);
			//push to exit helpmsg
			backBtn=new Button(Assets.getTexture("backbtn"));
			backBtn.x=400;
			backBtn.y=600;
			backBtn.addEventListener(Event.TRIGGERED, onBackClick);
			this.addChild(backBtn);
		}
		
		private function onPlayClick(event:Event):void
		{
			saveFile.clear();
			saveFile.data.saved=false;
			this.dispatchEventWith("play",true);
		}
		private function onContClick(event:Event):void
		{
			saveFile.data.saved=true;
			this.dispatchEventWith("play",true);
		}
		private function onHelpClick(event:Event):void
		{
			playBtn.visible=false;
			contBtn.visible=false;
			helpBtn.visible=false;
			quitBtn.visible=false;
			backBtn.visible=true;
			helpMsg.visible=true;
		}
		private function onQuitClick(event:Event):void
		{
			NativeApplication.nativeApplication.exit();
		}
		private function onBackClick(event:Event):void
		{
			playBtn.visible=true;
			contBtn.visible=true;
			helpBtn.visible=true;
			quitBtn.visible=true;
			backBtn.visible=false;
			helpMsg.visible=false;
		}
		public function disposeTemporarily():void
		{
			this.visible = false;
		}
		
		
	}
}