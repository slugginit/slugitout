// ActionScript file
package utilities {
	public class IntPoint {
		public var x:int;	
		public var y:int;
		public var z:int;
		
		public function IntPoint(x:int, y:int, z:int) {
			this.x = x;
			this.y = y;
			this.z = z;
		}
		
		public function distanceFrom(other:IntPoint) : Number {
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
		
		public function add(other:IntPoint):void {
			this.x += other.x;
			this.y += other.y;
			this.z += other.z;
		}
		
		public function toAbs():void {
			x = Math.abs(x);
			y = Math.abs(y);
			z = Math.abs(z);
		}
		
	}
}