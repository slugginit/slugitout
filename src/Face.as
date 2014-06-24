package {
	import starling.display.Quad;
	import starling.display.Sprite;
	import starling.utils.Color;
	
	import utilities.Matrix;
	import utilities.Point;
	import utilities.IntPoint;

	public class Face extends Sprite{
		private static var LINE_WIDTH: int = 5;
		
		private var points:Vector.<IntPoint>;
		private var normal:Point;
		private var edges:Vector.<Edge>;
		
		public function Face(points:Vector.<IntPoint>, normal:Point) {
			this.points = points;
			this.normal = normal;
			
			determineEdges();
		}
		
		private function determineEdges():void {
			edges = new Vector.<Edge>();
			
			for (var i:int = 0; i < points.length; i++) {
				var p:IntPoint = points[i];
				for (var k:int = i; k < points.length; k++) {
					if (p.distanceFrom(points[k]) == 1) {
						//trace("Adding edge from " + p + " to " + points[k]);
						edges.push(new Edge(p, new Point(points[k].x - p.x, points[k].y - p.y, points[k].z - p.z)));
					}
				}
			}
		}
		
		public function drawFace(cameraAngle: Number, rotation: Point, position:IntPoint, placed:Boolean):void {
			//remove all children
			this.removeChildren(0, this.numChildren);
			
			//rotate normal
			var rotationMatrix:Matrix = new Matrix(rotation.x, rotation.y + cameraAngle, rotation.z);
			var adjustedNormal: Point = rotationMatrix.rotate(normal);
			adjustedNormal.makeUnitVector();
			//trace(adjustedNormal.x + "," + adjustedNormal.y + "," + adjustedNormal.z);
			
			//if normal isn't pointing away, draw this face
			var lineWidth:int = 1;
			if (isVisible(adjustedNormal)) {
				lineWidth = 5;
			}
			
			
			//trace("Attempting to draw face");
			var z_length:Number = Constant.BLOCK_WIDTH*.5;
			var zx_offset:Number = Math.cos(Constant.ISOMETRIC_ANGLE)*z_length;
			var zy_offset:Number = Math.sin(Constant.ISOMETRIC_ANGLE)*z_length;
			//trace("y angle: " + (cameraAngle + rotation.y) + " zx_offset: " + zx_offset + " x angle " + rotation.x + " zy_offset: " + zy_offset);
			
			//draw edges
			for (var i:int; i < edges.length; i++) {
				//rotate points and edges by cameraAngle+rotation
				edges[i].updateRotation(rotationMatrix);
				//trace("Drawing edge " + edges[i].rotatedPos + " " + edges[i].rotatedDir);
				
				var quad:Quad = new Quad(Constant.BLOCK_WIDTH, 1 , placed? Color.BLUE : Color.RED);
				if (edges[i].rotatedDir.z != 0)
					quad.width = z_length;
				quad.rotation = edges[i].getRotateAngle();
				
				
				quad.x = Constant.SUITCASE_OFFSET.x + edges[i].rotatedPos.x*Constant.BLOCK_WIDTH - zx_offset*edges[i].rotatedPos.z + position.x*Constant.BLOCK_WIDTH - Math.cos(Constant.ISOMETRIC_ANGLE)*position.z*Constant.BLOCK_WIDTH*.5;
				quad.y = Constant.SUITCASE_OFFSET.y + -edges[i].rotatedPos.y*Constant.BLOCK_WIDTH - zy_offset*edges[i].rotatedPos.z + position.y*Constant.BLOCK_WIDTH - Math.sin(Constant.ISOMETRIC_ANGLE)*position.z*Constant.BLOCK_WIDTH*.5;
				//trace("\t" + quad.x + ", " + quad.y);
				
				this.addChild(quad);
			}
				
			
		}
		
		private function isVisible(adjustedNormal:Point) : Boolean {
			if (adjustedNormal.x == 1)
				return false;
			if (adjustedNormal.y == -1)
				return false;
			if (adjustedNormal.z == 1)
				return false;
			
			return true;
		}
		
		
		
	}
}