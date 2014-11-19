package utilities {
	public class Point {
		public var x:Number;	
		public var y:Number;
		public var z:Number;
		
		public function Point(x:Number=NaN, y:Number=NaN, z:Number=NaN) {
			this.x = x;
			this.y = y;
			this.z = z;
		}
		
		public function distanceFrom(other:Point) : Number {
			return Math.sqrt(Math.pow(x - other.x, 2) + Math.pow(y - other.y, 2) + Math.pow(z - other.z, 2));
		}
		
		public function getVectorLength(): Number {
			return Math.sqrt(x*x + y*y + z*z);	
		}
		
		public function makeUnitVector(): void {
				var length:Number = getVectorLength();
				x = x/length;
				y = y/length;
				z = z/length;
		}
		
		public function initFromArray(arr:Array):void {
			x = arr[0];
			y = arr[1];
			z = arr[2];
		}
		
		public function toString():String {
			return "(" + x + "," + y + "," + z + ")";
		}
		
		public function add(other:Point):void {
			this.x += other.x;
			this.y += other.y;
			this.z += other.z;
		}
		
		public function copy():Point {
			return new Point(x, y, z);	
		}
		
	}
}