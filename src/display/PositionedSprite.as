package display
{
	import starling.display.Image;
	
	import utilities.IntPoint;
	import utilities.Matrix;
	import utilities.Point;
	
	public class PositionedSprite
	{		
		public var position:Point;
			
			
		public var imageIndex:int = 0;
		public var sprite:Image = null;
		public var spritePrefix:String;
		
		public function PositionedSprite(image:Image, cameraRotation:Number, pos:IntPoint)
		{
			position = new Point(pos.x, pos.y, pos.z);
			
			sprite = image;
			
			//have to rotate position by camera rotation
			var cameraMat:Matrix = new Matrix(0, Math.PI*cameraRotation/2, 0);
			position = cameraMat.rotate(position);
			
			var xx:int = Constant.SUITCASE_OFFSET[cameraRotation].x + position.x*Constant.BLOCK_WIDTH - Constant.ZX_OFFSET*position.z - 250 + 50;
			var yy:int = Constant.SUITCASE_OFFSET[cameraRotation].y - position.y*Constant.BLOCK_WIDTH - Constant.ZY_OFFSET*position.z - sprite.height + 125;
			
			sprite.x = xx;
			sprite.y = yy;
		}
		
	}
}