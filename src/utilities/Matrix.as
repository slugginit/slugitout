// ActionScript file
package utilities {

	public class Matrix {
		private var matrix:Array;
		private var a:Number,b:Number,c:Number;
		
		public function Matrix (a:Number, b:Number, c:Number) {
			this.a = a;
			this.b = b;
			this.c = c;
			matrix = new Array(4);
			matrix[0] = new Array(Math.round(Math.cos(b)*Math.cos(c)), 
					Math.round(Math.cos(c)*Math.sin(a)*Math.sin(b) - Math.cos(a)*Math.sin(c)),
					Math.round(Math.cos(a)*Math.cos(c)*Math.sin(b) + Math.sin(a)*Math.sin(c)),
						0);
			matrix[1] = new Array(Math.round(Math.cos(b)*Math.sin(c)),
					Math.round(Math.cos(a)*Math.cos(c) + Math.sin(a)*Math.sin(b)*Math.sin(c)),
					Math.round(-Math.cos(c)*Math.sin(a) + Math.cos(a)*Math.sin(b)*Math.sin(c)),
						0);
			matrix[2] = new Array(Math.round(-Math.sin(b)),
					Math.round(Math.cos(b)*Math.sin(a)),
					Math.round(Math.cos(a)*Math.cos(b)),
							0);
			matrix[3] = new Array(0, 0, 0, 1);
		}
		
		
		
		public function toString() : String {
			return matrix[0] + ", " + matrix[1] + ", " + matrix[2];
		}
		
		public function rotate(point: Point) : Point {
			//trace( "Rotating point: " + point.toString() + " by (" + a + "," + b + "," + c + ")");
			
			return new Point(matrix[0][0]*point.x + matrix[0][1]*point.y + matrix[0][2]*point.z,
					matrix[1][0]*point.x + matrix[1][1]*point.y + matrix[1][2]*point.z,
					matrix[2][0]*point.x + matrix[2][1]*point.y + matrix[2][2]*point.z);
		}
		
		public function rotateInt(point: IntPoint) : IntPoint {
			return new IntPoint(matrix[0][0]*point.x + matrix[0][1]*point.y + matrix[0][2]*point.z,
				matrix[1][0]*point.x + matrix[1][1]*point.y + matrix[1][2]*point.z,
				matrix[2][0]*point.x + matrix[2][1]*point.y + matrix[2][2]*point.z);
		}
		
	}
}