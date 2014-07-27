package display
{
	import starling.display.Sprite;
	
	public class DisplayQueue extends Sprite
	{
		private static var displayQueue:Vector.<PositionedSprite> = new Vector.<PositionedSprite>();
		
		
		
		public static function addSprite(sprite:PositionedSprite):void {
			displayQueue.push(sprite);
			trace("Adding sprite to display queue: " + displayQueue.length);
		}
		
		public function clearQueue():void {
			displayQueue = new Vector.<PositionedSprite>();
		}
		
		public function drawObjects():void {
			this.removeChildren(0, this.numChildren);
			displayQueue.sort(sortLogic);
			for (var i:int = 0; i < displayQueue.length; i++) {
				this.addChild(displayQueue[i].sprite);
			}
			trace("drawing objects");
		}
		
		private static function sortLogic(a:PositionedSprite, b:PositionedSprite):int {
			if (a.position.z != b.position.z) 
				return b.position.z - a.position.z;
			if (a.position.y != b.position.y)
				return a.position.y - b.position.y;
			return b.position.x - a.position.x;
		}
		
	}
}