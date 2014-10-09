// ActionScript file
package {
	
	import display.DisplayQueue;
	
	import flash.events.EventDispatcher;
	import flash.net.dns.AAAARecord;
	
	import starling.display.Quad;
	import starling.display.Sprite;
	import starling.utils.Color;
	
	import utilities.IntPoint;
	import utilities.Matrix;
	import utilities.Point;
	import utilities.SkeletonPoint;

	public class Suitcase extends Sprite {
		public var orientation: IntPoint;
		public var size: IntPoint;
		private var rotatedBag:IntPoint;
		
		public var contents:Array;
		private var placedItems:Vector.<Item> = new Vector.<Item>();
		private var queuedItems:Vector.<Item> = new Vector.<Item>();
		private var item_index:int = 0;
		
		private var zx_offset: Number = Math.cos(Constant.ISOMETRIC_ANGLE)*Constant.BLOCK_WIDTH*.5;
		private var zy_offset: Number = Math.sin(Constant.ISOMETRIC_ANGLE)*Constant.BLOCK_WIDTH*.5;
		
		public var done:Boolean = false;
		
		
		private var displayQueue:DisplayQueue = new DisplayQueue();
		
		public function Suitcase(size:IntPoint) {
			Constant.SUITCASE_OFFSET = new Array(4);
			Constant.SUITCASE_OFFSET[0] = new IntPoint(500, 600, 0);
			Constant.SUITCASE_OFFSET[1] = new IntPoint(400, 500, 0);
			Constant.SUITCASE_OFFSET[2] = new IntPoint(900, 500, 0);
			Constant.SUITCASE_OFFSET[3] = new IntPoint(900, 600, 0);
			
			
			orientation = new IntPoint(0, 0, 0);
			this.size = size;
			
			contents = new Array(size.x);
			for (var i:int = 0; i < size.x; i++) {
				contents[i] = new Array(size.y);
				for (var k:int = 0; k < size.y; k++) {
					contents[i][k] = new Array(size.z);
					for (var j:int = 0; j < size.z; j++)
						contents[i][k][j] = false;
				}
			}
			
			placedItems = new Vector.<Item>();
		}
		
		public function addFirstItem(filename:String, prefix:String, dispatcher:EventDispatcher):void {
			var item: Item = new Item(prefix);
			item.addDispatcher(dispatcher);
			item.loadFile(filename);
			queuedItems.push(item);
		}
		
		public function addItemtoQueue(filename:String, prefix:String) : void {
			var item: Item = new Item(prefix);
			item.loadFile(filename);
			queuedItems.push(item);
		}
		
		public function cycleQueuedItem(direction :int) : void {
			item_index = (item_index + direction + queuedItems.length)%queuedItems.length;
			moveItem(new IntPoint(0, 0, 0), new Point(0, 0, 0));
		}
		
		
		public function placeItem():Boolean {
			var item:Item = queuedItems[item_index];
			//if the item can't be placed don't place it
			if (!item.placeable) return false;
				
			//fill in blocks contained by faces
			for (var i :int = 0; i < item.positionedSkeleton.length; i++) {
				//rotate point by current rotation and place it
				var p:IntPoint = item.positionedSkeleton[i].point;
				trace("Placing item at " + p.toString());
				contents[p.x][p.y][p.z] = true;
			}
			
			//add item to plced and remove it from queued
			item.placed = true;
			placedItems.push(item);	
			queuedItems.splice(item_index, 1);
			
			cycleQueuedItem(0);
			if (queuedItems.length == 0) {
				done = true;
				return true;
			}
			addChild(queuedItems[item_index]);
			drawItem(queuedItems[item_index]);
			
			return true;
		}
		
		public function drawSuitcase():void {
			this.removeChildren(0, this.numChildren);
			displayQueue.clearQueue();
			
			//draw objects
			for (i = 0; i < placedItems.length; i++){
				placedItems[i].drawObjectGuidelines(orientation.y, size.y, Color.GRAY);
				this.addChild(placedItems[i]);
			}
			//draw queued item guidelines
			if (queuedItems.length > 0) {
				queuedItems[item_index].drawObjectGuidelines(orientation.y, size.y, Color.BLUE);
				this.addChild(queuedItems[item_index]);
			}
			
			displayQueue.drawObjects();
			this.addChild(displayQueue);
			
			//draw guidelines
			//trace("Rotated bag: " + rotatedBag.toString() + " rotation: " + orientation.y);
			for (var i:int = 0; i < size.y; i++) {
				//front face horizontal lines
				var frontQuad:Quad = new Quad(Constant.BLOCK_WIDTH*(rotatedBag.x), 1, Color.WHITE);
				frontQuad.x = Constant.SUITCASE_OFFSET[orientation.y].x;
				frontQuad.y = Constant.SUITCASE_OFFSET[orientation.y].y - i*Constant.BLOCK_WIDTH;
				if (rotatedBag.z < 0) {
					frontQuad.x -= (rotatedBag.z+1)*zx_offset;
					frontQuad.y -= (rotatedBag.z+1)*zy_offset;
				}
				if (rotatedBag.x < 0) frontQuad.x += Constant.BLOCK_WIDTH;
				this.addChild(frontQuad);
				
				//left face horizontal lines
				var leftQuad:Quad = new Quad(Constant.BLOCK_WIDTH*rotatedBag.z*.5, 1, Color.WHITE);
				leftQuad.rotation = Math.PI + Constant.ISOMETRIC_ANGLE;
				leftQuad.x = Constant.SUITCASE_OFFSET[orientation.y].x;
				if (rotatedBag.x < 0) leftQuad.x += (rotatedBag.x+1)*Constant.BLOCK_WIDTH;
				leftQuad.y = Constant.SUITCASE_OFFSET[orientation.y].y - i*Constant.BLOCK_WIDTH;
				if (rotatedBag.z < 0) {
					leftQuad.x -= zx_offset;
					leftQuad.y -= zy_offset;
				}
				this.addChild(leftQuad);
			}
			
			for (var k:int = 0; k <= Math.abs(rotatedBag.x); k++) {
				//front face vertical lines
				var vertQuad:Quad = new Quad(Constant.BLOCK_WIDTH*(size.y), 1, Color.WHITE);
				vertQuad.rotation = Math.PI/2;
				vertQuad.x = Constant.SUITCASE_OFFSET[orientation.y].x + k*Constant.BLOCK_WIDTH;
				vertQuad.y = Constant.SUITCASE_OFFSET[orientation.y].y - (rotatedBag.y)*Constant.BLOCK_WIDTH;
				if (rotatedBag.z < 0) {
					vertQuad.x -= (rotatedBag.z+1)*zx_offset;
					vertQuad.y -= (rotatedBag.z+1)*zy_offset;
				}
				if (rotatedBag.x < 0) vertQuad.x += (rotatedBag.x+1)*Constant.BLOCK_WIDTH;
				this.addChild(vertQuad);
				
				
				//top face vertical lines
				var topQuad:Quad = new Quad(Constant.BLOCK_WIDTH*(rotatedBag.z)*.5, 1, Color.WHITE);
				topQuad.rotation = Math.PI + Constant.ISOMETRIC_ANGLE;
				topQuad.x = Constant.SUITCASE_OFFSET[orientation.y].x + k*Constant.BLOCK_WIDTH;
				if (rotatedBag.x < 0) topQuad.x += (rotatedBag.x+1)*Constant.BLOCK_WIDTH;
				topQuad.y = Constant.SUITCASE_OFFSET[orientation.y].y - (rotatedBag.y)*Constant.BLOCK_WIDTH;
				if (rotatedBag.z < 0) {
					topQuad.x -= zx_offset;
					topQuad.y -= zy_offset;
				}
				this.addChild(topQuad);
			}
			
			for (var j:int = 0; j <= Math.abs(rotatedBag.z); j++) {
				//top face horizontal lines
				var topZQuad:Quad = new Quad(Constant.BLOCK_WIDTH*(rotatedBag.x), 1, Color.WHITE);
				topZQuad.x = Constant.SUITCASE_OFFSET[orientation.y].x - zx_offset*j;
				if (rotatedBag.x < 0) topZQuad.x += Constant.BLOCK_WIDTH;
				topZQuad.y = Constant.SUITCASE_OFFSET[orientation.y].y - zy_offset*j - (rotatedBag.y)*Constant.BLOCK_WIDTH;
				if (rotatedBag.z < 0) {
					topZQuad.x -= (rotatedBag.z+1)*zx_offset;
					topZQuad.y -= (rotatedBag.z+1)*zy_offset;
				}
				this.addChild(topZQuad);
				
				
				//left face vertical lines
				var leftZQuad:Quad = new Quad(Constant.BLOCK_WIDTH*(size.y), 1, Color.WHITE);
				leftZQuad.rotation = Math.PI/2;
				leftZQuad.x = Constant.SUITCASE_OFFSET[orientation.y].x - zx_offset*j;
				if (rotatedBag.x < 0) leftZQuad.x += (rotatedBag.x+1)*Constant.BLOCK_WIDTH;
				leftZQuad.y = Constant.SUITCASE_OFFSET[orientation.y].y - zy_offset*j - (size.y)*Constant.BLOCK_WIDTH;
				if (rotatedBag.z < 0) {
					leftZQuad.x -= (rotatedBag.z+1)*zx_offset;
					leftZQuad.y -= (rotatedBag.z+1)*zy_offset;
				}
				this.addChild(leftZQuad);
				
			}
			
			//draw placed item guidelines
			for (i = 0; i < placedItems.length; i++){
				drawPlacedItem(placedItems[i]);
			}
			//draw queued item guidelines
			if (queuedItems.length > 0) {
				drawItem(queuedItems[item_index]);
			}
			
			
		}
		
		public function getQueueditem() : Item {
			return queuedItems[item_index];
		}
		
		private function drawItem(item: Item) : void {
			var cameraMat:Matrix = new Matrix(0, Math.PI*orientation.y/2, 0);
			
			//green out quads where the item is being placed
			for (var x: int = 0; x < item.positionedSkeleton.length; x++) {
				//rotate this point
				var p:IntPoint = cameraMat.rotateInt(item.positionedSkeleton[x].point);
				var placeable:Boolean = item.positionedSkeleton[x].placeable;
				
				//x face
				var placingQuadFront:Quad = new Quad(Constant.BLOCK_WIDTH, -Constant.BLOCK_WIDTH, placeable ? Color.GREEN : Color.RED);
				placingQuadFront.x = Constant.SUITCASE_OFFSET[orientation.y].x + (p.x)*Constant.BLOCK_WIDTH;
				placingQuadFront.y = Constant.SUITCASE_OFFSET[orientation.y].y - (p.y)*Constant.BLOCK_WIDTH;
				if (rotatedBag.z < 0) {
					placingQuadFront.x -= zx_offset*(rotatedBag.z+1);
					placingQuadFront.y -= zy_offset*(rotatedBag.z+1);
				}
				placingQuadFront.alpha = 0.25;
				this.addChild(placingQuadFront);
				
				//y face
				var placingQuadTop:Quad = new Quad(Constant.BLOCK_WIDTH, -Constant.BLOCK_WIDTH*.5, placeable ? Color.GREEN : Color.RED);
				placingQuadTop.x = Constant.SUITCASE_OFFSET[orientation.y].x + (p.x)*Constant.BLOCK_WIDTH - zx_offset*(p.z);
				placingQuadTop.y = Constant.SUITCASE_OFFSET[orientation.y].y - (size.y)*Constant.BLOCK_WIDTH - zy_offset*(p.z);
				placingQuadTop.skewX = -(Math.PI/2 - Constant.ISOMETRIC_ANGLE);
				placingQuadTop.alpha = 0.25;
				this.addChild(placingQuadTop);
				
				//z face
				var placingQuadLeft:Quad = new Quad(-Constant.BLOCK_WIDTH*.5, -Constant.BLOCK_WIDTH, placeable ? Color.GREEN : Color.RED);
				placingQuadLeft.x = Constant.SUITCASE_OFFSET[orientation.y].x - zx_offset*(p.z);
				placingQuadLeft.y = Constant.SUITCASE_OFFSET[orientation.y].y - (p.y)*Constant.BLOCK_WIDTH - zy_offset*(p.z);
				if (rotatedBag.x < 0) placingQuadLeft.x += (rotatedBag.x+1)*Constant.BLOCK_WIDTH;
				placingQuadLeft.skewY =  Constant.ISOMETRIC_ANGLE;
				placingQuadLeft.alpha = .25;
				this.addChild(placingQuadLeft);
				
			}
		}
		
		private function drawPlacedItem(item: Item) : void {
			//green out quads where the item is being placed
			for (var x: int = 0; x < item.positionedSkeleton.length; x++) {
				//rotate this point
				var p:IntPoint = item.positionedSkeleton[x].point;
				var placeable:Boolean = item.positionedSkeleton[x].placeable;
				
				//x face
				var placingQuadFront:Quad = new Quad(Constant.BLOCK_WIDTH, -Constant.BLOCK_WIDTH, Color.GRAY);
				placingQuadFront.x = Constant.SUITCASE_OFFSET[orientation.y].x + (p.x)*Constant.BLOCK_WIDTH;
				placingQuadFront.y = Constant.SUITCASE_OFFSET[orientation.y].y - (p.y)*Constant.BLOCK_WIDTH;
				placingQuadFront.alpha = 0.25;
				this.addChild(placingQuadFront);
				
				//y face
				var placingQuadTop:Quad = new Quad(Constant.BLOCK_WIDTH, -Constant.BLOCK_WIDTH*.5,  Color.GRAY);
				placingQuadTop.x = Constant.SUITCASE_OFFSET[orientation.y].x + (p.x)*Constant.BLOCK_WIDTH - zx_offset*(p.z);
				placingQuadTop.y = Constant.SUITCASE_OFFSET[orientation.y].y - (size.y)*Constant.BLOCK_WIDTH - zy_offset*(p.z);
				placingQuadTop.skewX = -(Math.PI/2 - Constant.ISOMETRIC_ANGLE);
				placingQuadTop.alpha = 0.25;
				this.addChild(placingQuadTop);
				
				//z face
				var placingQuadLeft:Quad = new Quad(-Constant.BLOCK_WIDTH*.5, -Constant.BLOCK_WIDTH,  Color.GRAY);
				placingQuadLeft.x = Constant.SUITCASE_OFFSET[orientation.y].x - zx_offset*(p.z);
				placingQuadLeft.y = Constant.SUITCASE_OFFSET[orientation.y].y - (p.y)*Constant.BLOCK_WIDTH - zy_offset*(p.z);
				placingQuadLeft.skewY =  Constant.ISOMETRIC_ANGLE;
				placingQuadLeft.alpha = .25;
				this.addChild(placingQuadLeft);
				
			}
		}
		
		public function rotateCamera(cameraOffset:Number) : void {
			orientation.y += (cameraOffset + 4);
			orientation.y = orientation.y%4;
			trace("Orientation is " + orientation.y);
			
			var cameraMat:Matrix = new Matrix(0, Math.PI*orientation.y/2, 0);
			rotatedBag = cameraMat.rotateInt(size);
			
			//rotate all the items while we're at it
			for (var i:int = 0; i < placedItems.length; i++)
				placedItems[i].rotateItem(new Point(0, -cameraOffset*Math.PI/2, 0));
			if (queuedItems.length > 0)
				queuedItems[item_index].rotateItem(new Point(0, -cameraOffset*Math.PI/2, 0));
							
		}
		
		public function moveItem(transPoint:IntPoint, rotPoint:Point) :void {
			
			if (queuedItems.length == 0)
				return;
			
			var item:Item = queuedItems[item_index];
			var cameraMat:Matrix = new Matrix(0, -Math.PI*orientation.y/2, 0);
			trace("Old transPoint: " + transPoint + " old position: " + item.position);
			transPoint = cameraMat.rotateInt(transPoint);
			
			item.position.add(transPoint);
			trace("New transPoint: " + transPoint + " new position: " + item.position);

			
			var rotMat:Matrix = new Matrix(rotPoint.x, rotPoint.y, rotPoint.z);
			
			//var rotMat:Matrix = new Matrix (item.orientation.x, item.orientation.y, item.orientation.z);
			var minPoints:Point = new Point(0, 0, 0);
			var maxPoints:Point = new Point(0, 0, 0);
			var p:IntPoint;
			
			//rotate the skeleton - move it if it is out of bounds, otherwise just check it
			item.rotateItem(rotPoint);
			item.positionedSkeleton = new Vector.<SkeletonPoint>();
			for (var i:int = 0; i < item.skeleton.length; i++) {
				//item.skeleton[i] = rotMat.rotateInt(item.skeleton[i]);
				p = rotMat.rotateInt(item.skeleton[i]);
				item.skeleton[i] = new IntPoint(p.x, p.y, p.z);
				
				if (p.x < minPoints.x) minPoints.x = p.x;
				if (p.y < minPoints.y) minPoints.y = p.y;
				if (p.z < minPoints.z) minPoints.z = p.z;
				
				if (p.x > maxPoints.x) maxPoints.x = p.x;
				if (p.y > maxPoints.y) maxPoints.y = p.y;
				if (p.z > maxPoints.z) maxPoints.z = p.z;
				
				item.positionedSkeleton.push(new SkeletonPoint(p));
			}
			
			//trace("Max points: " + maxPoints.toString());
			//trace("Min points: " + minPoints.toString());
			
			//just enforce the boundaries on the 0, 0 point so they don't get too far out of the suitcase
			if (item.position.x + minPoints.x < 0) item.position.x = -minPoints.x;
			if (item.position.z + minPoints.z < 0) item.position.z = -minPoints.z;
			if (item.position.x + maxPoints.x >= size.x) item.position.x = size.x - maxPoints.x - 1;
			if (item.position.z + maxPoints.z >= size.z) item.position.z = size.z - maxPoints.z - 1;
			
			//position skeleton y-level
			var y_pos:int = size.y - maxPoints.y;
			for (var y:int = -minPoints.y; y < size.y - maxPoints.y; y++) {
				var valid:Boolean = true;
				for (var k:int = 0; k < item.positionedSkeleton.length; k++) {
					p = item.positionedSkeleton[k].point;
					if (contents[item.position.x + p.x][y][item.position.z + p.z] == true) valid = false;
				}
				
				if (valid) {
					y_pos = y;
					break;
				}
			}
			
			item.position.y = y_pos;
			
			//one more pass to color x and z levels
			item.placeable = true;
			for (i = 0; i < item.positionedSkeleton.length; i++) {
				item.positionedSkeleton[i].point.add(item.position);
				p = item.positionedSkeleton[i].point;
				//trace("Positioned Skeleton " + i + " position: " + p.toString());
				if (p.y >= size.y) {
					item.positionedSkeleton[i].placeable = false;
					item.placeable = false;
				}
				else if (!contents[p.x][p.y][p.z]) {
					item.positionedSkeleton[i].placeable = true;
				}
				else {
					item.positionedSkeleton[i].placeable = false;
					item.placeable = false;
				}
			}
		
		}
		
	}
}