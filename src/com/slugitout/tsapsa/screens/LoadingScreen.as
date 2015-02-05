package com.slugitout.tsapsa.screens {
	import starling.display.Image;
	import starling.display.Sprite;
	
	public class LoadingScreen extends Sprite {
		public var loadingBackground:Image;
		
		public function LoadingScreen() {
			loadingBackground = new Image(Assets.getTexture("loadingBackground"));
		}
		
		public function drawLoadingScreen() {
			this.removeChildren(0, this.numChildren);
			loadingBackground.x = stage.stageWidth/2 - loadingBackground.width/2;
			loadingBackground.y = stage.stageHeight/2 - loadingBackground.height/2;
			this.addChild(loadingBackground);
		}
		
	}
	
}