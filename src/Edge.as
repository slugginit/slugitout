package {
	import utilities.Point;
	import utilities.Matrix;
	import utilities.IntPoint;

	public class Edge {
		public var position:IntPoint;
		public var direction:Point;
		
		public var rotatedPos:IntPoint;
		public var rotatedDir:Point;
		
		public function Edge(point:IntPoint, direction:Point) {
				this.position = point;
				this.direction = direction;
				//trace("position: " + point + " direction: " + direction);
		}
		
		public function updateRotation(mat:Matrix):void {
			rotatedPos = mat.rotateInt(position);
			rotatedDir = mat.rotate(direction);
			
			if (Math.abs(rotatedDir.x) < .1)
				rotatedDir.x = 0;
			if (Math.abs(rotatedDir.y) < .1)
				rotatedDir.y = 0;
			if (Math.abs(rotatedDir.z) < .1)
				rotatedDir.z = 0;
		}
		
		public function getRotateAngle() :Number {
			var angle:Number = 0;
			
			if (rotatedDir.x == -1)
				angle = Math.PI;
			if (rotatedDir.y != 0)
				angle = -Math.PI/2*rotatedDir.y;
			if (rotatedDir.z == 1)
				angle = Math.PI + Constant.ISOMETRIC_ANGLE;
			if (rotatedDir.z == -1)
				angle = Constant.ISOMETRIC_ANGLE;
			
			//trace ("\tVector to angle: " + rotatedDir + ": " + angle/Math.PI + " PI");
			return angle;
		}

	}
}