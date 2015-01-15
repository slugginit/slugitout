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

	public class MenuScreen extends Sprite
	{
		/** Background image. */
		private var bg:Image;
		
		///** Game title. */
		//private var title:Image;
		
		private var helpMsg:TextField;
		/** Play button. */
		private var playBtn:Button;
		private var saveBtn1:Button;
		private var saveBtn2:Button;
		private var saveBtn3:Button;
		private var contBtn:Button;
		private var quitBtn:Button;
		private var helpBtn:Button;
		private var backBtn:Button;
		
		private var loaded:Boolean;
		private var saveFile1:SharedObject=SharedObject.getLocal("save1");
		private var saveFile2:SharedObject=SharedObject.getLocal("save2");
		private var saveFile3:SharedObject=SharedObject.getLocal("save3");
		
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
			saveBtn1.visible=false;
			saveBtn2.visible=false;
			saveBtn3.visible=false;
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
			if(saveFile1.data.placed==null&&saveFile2.data.placed==null&&saveFile3.data.placed==null){
				contBtn.enabled=false;
			}
			this.addChild(contBtn);
			//savebtns
			saveBtn1=new Button(Assets.getTexture("play"));
			saveBtn1.x=400;
			saveBtn1.y=150;
			//saveBtn1.addEventListener(Event.TRIGGERED, onPlayClick);
			this.addChild(saveBtn1);
			saveBtn2=new Button(Assets.getTexture("play"));
			saveBtn2.x=400;
			saveBtn2.y=300;
			//saveBtn2.addEventListener(Event.TRIGGERED, onPlayClick);
			this.addChild(saveBtn2);
			saveBtn3=new Button(Assets.getTexture("play"));
			saveBtn3.x=400;
			saveBtn3.y=450;
			//saveBtn3.addEventListener(Event.TRIGGERED, onPlayClick);
			this.addChild(saveBtn3);
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
			playBtn.visible=false;
			contBtn.visible=false;
			saveBtn1.visible=true;
			saveBtn2.visible=true;
			saveBtn3.visible=true;
			saveBtn1.enabled=true;
			saveBtn2.enabled=true;
			saveBtn3.enabled=true;
			helpBtn.visible=false;
			quitBtn.visible=false;
			backBtn.visible=true;
			saveBtn1.addEventListener(Event.TRIGGERED, onNewClick(1));
			saveBtn2.addEventListener(Event.TRIGGERED, onNewClick(2));
			saveBtn3.addEventListener(Event.TRIGGERED, onNewClick(3));
		}
		private function onContClick(event:Event):void
		{
			playBtn.visible=false;
			contBtn.visible=false;
			saveBtn1.visible=true;
			saveBtn2.visible=true;
			saveBtn3.visible=true;
			helpBtn.visible=false;
			quitBtn.visible=false;
			backBtn.visible=true;
			helpMsg.visible=false;
			saveBtn1.addEventListener(Event.TRIGGERED, onLoadClick(1));
			saveBtn2.addEventListener(Event.TRIGGERED, onLoadClick(2));
			saveBtn3.addEventListener(Event.TRIGGERED, onLoadClick(3));
			if(saveFile1.data.placed==null){
				saveBtn1.enabled=false;
			}
			if(saveFile2.data.placed==null){
				saveBtn2.enabled=false;
			}
			if(saveFile3.data.placed==null){
				saveBtn3.enabled=false;
			}
		}
		//
		private function onNewClick(filenum:int):Function
		{
			return function(event:Event):void{
				switch (filenum){
					case 1:
					if(saveFile1.data.placed!=null){
						saveFile1.clear();
						saveFile1.data.saved=false;
					}
					saveFile1.data.loaded=true;
					saveFile2.data.loaded=false;
					saveFile3.data.loaded=false;
					break;
					
					case 2:
					if(saveFile2.data.placed!=null){						
						saveFile2.clear();
						saveFile2.data.saved=false;
					}
					saveFile1.data.loaded=false;
					saveFile2.data.loaded=true;
					saveFile3.data.loaded=false;
					break;
					
					case 3:
					if(saveFile3.data.placed!=null){
						saveFile3.clear();
						saveFile3.data.saved=false;
					}
					saveFile1.data.loaded=false;
					saveFile2.data.loaded=false;
					saveFile3.data.loaded=true;
					break;
				}

			this.dispatchEventWith("play",true);
			}

		}
		private function onLoadClick(filenum:int):Function
		{
			return function(event:Event):void{
				switch (filenum){
					case 1:
						saveFile1.data.loaded=true;
						saveFile2.data.loaded=false;
						saveFile3.data.loaded=false;
						break;
					
					case 2:
						saveFile1.data.loaded=false;
						saveFile2.data.loaded=true;
						saveFile3.data.loaded=false;
						break;
					
					case 3:
						saveFile1.data.loaded=false;
						saveFile2.data.loaded=false;
						saveFile3.data.loaded=true;
						break;
				}
				this.dispatchEventWith("play",true);
			}
			
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
			saveBtn1.visible=false;
			saveBtn2.visible=false;
			saveBtn3.visible=false;
			saveBtn1.removeEventListener(Event.TRIGGERED, onNewClick(1));
			saveBtn2.removeEventListener(Event.TRIGGERED, onNewClick(2));
			saveBtn3.removeEventListener(Event.TRIGGERED, onNewClick(3));
			saveBtn1.removeEventListener(Event.TRIGGERED, onLoadClick(1));
			saveBtn2.removeEventListener(Event.TRIGGERED, onLoadClick(2));
			saveBtn3.removeEventListener(Event.TRIGGERED, onLoadClick(3));
		}
		public function disposeTemporarily():void
		{
			this.visible = false;
		}
		
		
	}
}