package display
{
	import starling.display.Image;
	
	import utilities.IntPoint;
	
	public class PositionedSprite
	{		
		public var position:IntPoint;
			
			
		public var imageIndex:int = 0;
		public var sprite:Image = null;
		public var spritePrefix:String;
		
		public function PositionedSprite(image:Image, cameraRotation:Number, pos:IntPoint)
		{
			position = pos;
			
			sprite = image;
			
			var xx:int = Constant.SUITCASE_OFFSET[cameraRotation].x + position.x*Constant.BLOCK_WIDTH - Constant.ZX_OFFSET*position.z - 250;
			var yy:int = Constant.SUITCASE_OFFSET[cameraRotation].y - position.y*Constant.BLOCK_WIDTH - Constant.ZY_OFFSET*position.z - sprite.height + 125;
			
			sprite.x = xx;
			sprite.y = yy;
		}
		
	}
}