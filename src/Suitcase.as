// ActionScript file
package {
	
	import com.slugitout.tsapsa.screens.LoadingScreen;
	
	import display.DisplayQueue;
	
	import flash.events.EventDispatcher;
	import flash.net.SharedObject;
	import flash.net.dns.AAAARecord;
	import flash.utils.Dictionary;
	import flash.ui.Keyboard;
	
	import starling.display.Image;
	import starling.display.Quad;
	import starling.display.Sprite;
	import starling.text.TextField;
	import starling.utils.Color;
	import starling.events.KeyboardEvent;
	
	import utilities.IntPoint;
	import utilities.Matrix;
	import utilities.Point;
	import utilities.SkeletonPoint;

	public class Suitcase extends Sprite {
		public var orientation: IntPoint;
		public var size: IntPoint;
		private var rotatedBag:IntPoint;
		
		public var contents:Array;
		private var saveArray:Array=new Array();
		private var nameArray:Array=new Array();
		private var imgarray:Array=new Array();
		
		private var storedItem:Item = null;
		private var placedItems:Vector.<Item> = new Vector.<Item>();
		private var queuedItems:Vector.<Item> = new Vector.<Item>();
		private var item_index:int = 0;
		
		private var z_scale: Number = .615;
		
		private var zx_offset: Number = Math.cos(Math.PI/4)*Constant.BLOCK_WIDTH*z_scale;
		private var zy_offset: Number = Math.sin(Math.PI/4)*Constant.BLOCK_WIDTH*z_scale;
		
		public var loaded:Boolean = false;
		public var done:Boolean = false;
		
		private var displayQueue:DisplayQueue = new DisplayQueue();
		
		private var saveFile:SharedObject;
		
		private var loadingScreen:LoadingScreen = new LoadingScreen();
		
		public var VICTORY:String = "victory";
		public var RETIRE:String = "retire";
		
		
		//background objects
		private var bucket:Image;
		private var belt:Image;
		
		public function getStoredItem() {
			return storedItem;
		}
		
		public function swapStoredItem() {
			if (storedItem != null)
				queuedItems.push(storedItem);
			
			storedItem = queuedItems[item_index];
			queuedItems.splice(item_index, 1);
			
			queuedItems.sort(Item.sort);
			
			cycleQueuedItem(0);
		}
		
		public function Suitcase(size:IntPoint, storedItem:Item) {
			Constant.SUITCASE_OFFSET = new Array(4);
			Constant.SUITCASE_OFFSET[0] = new IntPoint(500, 700, 0);
			Constant.SUITCASE_OFFSET[1] = new IntPoint(400, 500, 0);
			Constant.SUITCASE_OFFSET[2] = new IntPoint(900, 500, 0);
			Constant.SUITCASE_OFFSET[3] = new IntPoint(900, 600, 0);
			
			bucket = new Image(Assets.getTexture("bucket"));
			bucket.x = 0;
			bucket.y = 500;
			bucket.width = 256;
			bucket.height = 256;
			
			//draw the belt
			belt = new Image(Assets.getTexture("belt"));
			belt.x = 0;
			belt.y = 0;
			belt.width = 256;
			belt.height = 500;
			
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
			
			this.storedItem = storedItem;
			
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
		
		public function addLoadedItemToQueue(item:Item) : void {
			queuedItems.push(item);
		}
		
		public function cycleQueuedItem(direction :int) : void {
			if (direction == 0) {
				item_index = (item_index + direction + queuedItems.length)%queuedItems.length;
				return;
			}
			
			var originalIndex:int = item_index;
			var current:String = queuedItems[item_index].spritePrefix;
			
			while(queuedItems[item_index].spritePrefix == current) {
				item_index = (item_index + direction + queuedItems.length)%queuedItems.length;
				if (item_index == originalIndex) break;
			}
			trace("Original Index: " + originalIndex + " new index: " + item_index);
			moveItem(new IntPoint(0, 0, 0), new Point(0, 0, 0));
		}		
		
		public function placeItem():Boolean {
			if (queuedItems.length == 0) return false;
			
			var item:Item = queuedItems[item_index];
			//if the item can't be placed don't place it
			if (!item.placeable) return false;
				
			//fill in blocks contained by faces
			for (var i :int = 0; i < item.positionedSkeleton.length; i++) {
				//rotate point by current rotation and place it
				var p:IntPoint = item.positionedSkeleton[i].point;
				var array2:Array=new Array();
				//trace("Placing item at " + p.toString());
				contents[p.x][p.y][p.z] = true;
			}
			//add item to plced and remove it from queued
			item.placed = true;
			placedItems.push(item);
			queuedItems.splice(item_index, 1);
			cycleQueuedItem(0);
			placesave(item);
			if (queuedItems.length == 0) {
				done = true;
				saveFile.clear();
				saveFile.data.saved=false;
				saveFile.flush();
				return true;
			}
			
			addChild(queuedItems[item_index]);
			drawItem(queuedItems[item_index]);
			return true;
		}
		
		private function drawIcons():void {
			//draw belt and bucket
			this.addChildAt(bucket, 0);
			this.addChildAt(belt, 0);
			
			//draw icons
			var offset:int = 0;
			var currentPrefix:String = null;
			var selectedPrefix:String = queuedItems[item_index].spritePrefix;
			var count:int = 0;
			for (var i:int = 0; i < queuedItems.length; i++) {
				var prefix = queuedItems[i].spritePrefix;
				if (prefix != currentPrefix) {
					if (prefix == selectedPrefix) {
						var selectedSprite:Image = new Image(Assets.getTexture("selector"));
						selectedSprite.x = 15 +offset%2*115;
						selectedSprite.y = 15 + (int)(offset/2)*90;
						this.addChild(selectedSprite);
					}
					
					//draw the last count and this sprite
					if (count > 0) {
						var textField:TextField = new TextField(50, 50, count.toString(), "Arial", 36, Color.RED);
						textField.x = 85 + (offset-1)%2*115;
						textField.y = 15 + (int)((offset-1)/2)*90;
						
						this.addChild(textField);
					}
					
					var iconSprite:Image = new Image(Assets.getTexture(prefix + "Icon"));
					iconSprite.x = 15 +offset%2*115;
					iconSprite.y = 15 + (int)(offset/2)*90;
					
					offset++;
					this.addChild(iconSprite);
					
					currentPrefix = queuedItems[i].spritePrefix;
					count = 0;
				}
				
				count++;
			}
			//draw last textfield
			var textField:TextField = new TextField(50, 50, count.toString(), "Arial", 36, Color.RED);
			textField.x = 85 + (offset-1)%2*115;
			textField.y = 15 + (int)((offset-1)/2)*90;
			
			this.addChild(textField);
			
			//draw stored item
			if (storedItem != null) {
				var iconSprite:Image = new Image(Assets.getTexture(storedItem.spritePrefix + "Icon"));
				iconSprite.x = 65;
				iconSprite.y = 550;
				this.addChild(iconSprite);
				
			}
			
		}
	
		private function drawSuitcaseGuidelines():void {
			//draw guidelines
			//trace("Rotated bag: " + rotatedBag.toString() + " rotation: " + orientation.y);
			var left_offset:Number = Math.sin(Math.PI/4)*(Constant.BLOCK_WIDTH*.615);
			var baseQuad:Quad = new Quad(10, 10, Color.YELLOW);
			baseQuad.x = Constant.SUITCASE_OFFSET[orientation.y].x;
			baseQuad.y = Constant.SUITCASE_OFFSET[orientation.y].y;
			this.addChild(baseQuad);
			
			for (var i:int = 0; i < size.y; i++) {
				//front face horizontal lines
				var frontQuad:Quad = new Quad(Constant.BLOCK_WIDTH*(rotatedBag.x), 1, Color.GREEN);
				frontQuad.rotation = -Math.PI/24.0;
				frontQuad.x = Constant.SUITCASE_OFFSET[orientation.y].x;
				frontQuad.y = Constant.SUITCASE_OFFSET[orientation.y].y - i*Constant.BLOCK_WIDTH;
				if (rotatedBag.z < 0) {
					frontQuad.x -= (rotatedBag.z+1)*zx_offset;
					frontQuad.y -= (rotatedBag.z+1)*zy_offset;
				}
				if (rotatedBag.x < 0) {
					frontQuad.x += Constant.BLOCK_WIDTH;
				}
				this.addChild(frontQuad);
				
				//left face horizontal lines
				var leftQuad:Quad = new Quad(Constant.BLOCK_WIDTH*rotatedBag.z*.615, 1, Color.WHITE);
				leftQuad.rotation = -Math.PI*3/4;
				leftQuad.x = Constant.SUITCASE_OFFSET[orientation.y].x;
				leftQuad.y = Constant.SUITCASE_OFFSET[orientation.y].y - i*Constant.BLOCK_WIDTH;
				if (rotatedBag.x < 0) {
					leftQuad.x += (rotatedBag.x+1)*Constant.BLOCK_WIDTH;
					leftQuad.y += Math.sin(-Math.PI/24)*Constant.BLOCK_WIDTH*(rotatedBag.x);
				}
				if (rotatedBag.z < 0) {
					leftQuad.x -= zx_offset;
					leftQuad.y -= zy_offset;
				}
				this.addChild(leftQuad);
			}
			
			var horizontal_offset:Number = Math.tan(Math.PI/24)*Constant.BLOCK_WIDTH;
			var y_offset:Number = Math.sin(-Math.PI/4)*Constant.BLOCK_WIDTH*rotatedBag.z;
			
			for (var k:int = 0; k <= Math.abs(rotatedBag.x); k++) {
				//front face vertical lines
				var vertQuad:Quad = new Quad(Constant.BLOCK_WIDTH*(size.y), 1, Color.GREEN);
				vertQuad.rotation = -Math.PI/2;
				vertQuad.x = Constant.SUITCASE_OFFSET[orientation.y].x + k*Constant.BLOCK_WIDTH;
				vertQuad.y = Constant.SUITCASE_OFFSET[orientation.y].y - horizontal_offset*k;
				if (rotatedBag.z < 0) {
					vertQuad.x -= (rotatedBag.z+1)*zx_offset;
					vertQuad.y -= (rotatedBag.z+1)*zy_offset;
				}
				if (rotatedBag.x < 0) {
					vertQuad.x += (rotatedBag.x+1)*Constant.BLOCK_WIDTH;
					vertQuad.y += (rotatedBag.x)*Math.sin(-Math.PI/24)*Constant.BLOCK_WIDTH;
				}
				this.addChild(vertQuad);
				
				
				//top face vertical lines
				var topQuad:Quad = new Quad(Constant.BLOCK_WIDTH*(rotatedBag.z)*.615, 1, Color.PURPLE);
				topQuad.rotation = -Math.PI*3/4;
				topQuad.x = Constant.SUITCASE_OFFSET[orientation.y].x + k*Constant.BLOCK_WIDTH;
				topQuad.y = Constant.SUITCASE_OFFSET[orientation.y].y - (rotatedBag.y)*Constant.BLOCK_WIDTH - horizontal_offset*k;
				if (rotatedBag.x < 0) { 
					topQuad.x += (rotatedBag.x+1)*Constant.BLOCK_WIDTH; //(rotatedBag.x+1)*Constant.BLOCK_WIDTH;
					topQuad.y += Math.sin(-Math.PI/24)*Constant.BLOCK_WIDTH*rotatedBag.x;
				}
				if (rotatedBag.z < 0) {
					topQuad.x -= zx_offset;
					topQuad.y -= zy_offset;
				}
				this.addChild(topQuad);
			}
			
			for (var j:int = 0; j <= Math.abs(rotatedBag.z); j++) {
				//top face horizontal lines
				var topZQuad:Quad = new Quad(Constant.BLOCK_WIDTH*(rotatedBag.x), 1, Color.PURPLE);
				topZQuad.rotation = -Math.PI/24.0;
				topZQuad.x = Constant.SUITCASE_OFFSET[orientation.y].x - zx_offset*j;
				if (rotatedBag.x < 0) topZQuad.x += Constant.BLOCK_WIDTH;
				topZQuad.y = Constant.SUITCASE_OFFSET[orientation.y].y /*- zy_offset*j*/ - left_offset*j - (rotatedBag.y)*Constant.BLOCK_WIDTH;
				if (rotatedBag.z < 0) {
					topZQuad.x -= (rotatedBag.z+1)*zx_offset;
					topZQuad.y -= (rotatedBag.z+1)*zy_offset;
				}
				this.addChild(topZQuad);
				
				
				//left face vertical lines
				var leftZQuad:Quad = new Quad(Constant.BLOCK_WIDTH*(size.y), 1, Color.WHITE);
				leftZQuad.rotation = Math.PI/2;
				leftZQuad.x = Constant.SUITCASE_OFFSET[orientation.y].x /*- zx_offset*j */- left_offset*j;
				leftZQuad.y = Constant.SUITCASE_OFFSET[orientation.y].y - /*zy_offset*j -*/ (size.y)*Constant.BLOCK_WIDTH - left_offset*j;
				if (rotatedBag.x < 0) {
					leftZQuad.x += (rotatedBag.x+1)*Constant.BLOCK_WIDTH;
					leftZQuad.y += (rotatedBag.x)*Math.sin(-Math.PI/24)*Constant.BLOCK_WIDTH;
				}
				if (rotatedBag.z < 0) {
					leftZQuad.x -= (rotatedBag.z+1)*zx_offset;
					leftZQuad.y -= (rotatedBag.z+1)*zy_offset;
				}
				this.addChild(leftZQuad);
				
			}
			
			
		}
		
		public function drawSuitcase():void {
			this.removeChildren(0, this.numChildren);
			
			if(!loaded) {
				this.addChild(loadingScreen);
				loadingScreen.drawLoadingScreen();
				trace("not loaded yet");
				return;
			}
			
			displayQueue.clearQueue();
			
			//draw objects
			for (var i:int = 0; i < placedItems.length; i++){
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
			
			//draw suitcase skeleton
			drawSuitcaseGuidelines();
			
			
			
			//draw placed item guidelines
			for (i = 0; i < placedItems.length; i++){
				drawPlacedItem(placedItems[i]);
			}
			//draw queued item guidelines
			if (queuedItems.length > 0) {
				drawItem(queuedItems[item_index]);
				drawIcons();
			}
			
			
		}
		
		public function getQueueditem() : Item {
			return queuedItems[item_index];
		}
		
		private function drawItem(item: Item) : void {
			//don't do anything if item didn't get initialized
			if (!item.initialized){
				trace("Trying to draw an item that is not initialized: " + item.spritePrefix + " queue position: " + item_index);
				return;
			}
			
			var cameraMat:Matrix = new Matrix(0, Math.PI*orientation.y/2, 0);
			
			trace("Draw item: " + item.spritePrefix);
			//green out quads where the item is being placed
			for (var x: int = 0; x < item.positionedSkeleton.length; x++) {
				//rotate this point
				var p:IntPoint = cameraMat.rotateInt(item.positionedSkeleton[x].point);
				var placeable:Boolean = item.positionedSkeleton[x].placeable;
				
				//x face
				var placingQuadFront:Quad = new Quad(Constant.BLOCK_WIDTH, -Constant.BLOCK_WIDTH, placeable ? Color.GREEN : Color.RED);
				placingQuadFront.x = Constant.SUITCASE_OFFSET[orientation.y].x + (p.x)*Constant.BLOCK_WIDTH;
				placingQuadFront.y = Constant.SUITCASE_OFFSET[orientation.y].y - p.y*Constant.BLOCK_WIDTH - Math.sin(Math.PI/24)*Constant.BLOCK_WIDTH*p.x;
				placingQuadFront.skewY = -Math.PI/24;
				if (rotatedBag.z < 0) {
					placingQuadFront.x -= zx_offset*(rotatedBag.z+1);
					placingQuadFront.y -= zy_offset*(rotatedBag.z+1);
				}
				if(rotatedBag.x < 0) placingQuadFront.y += Math.sin(Math.PI/24)*Constant.BLOCK_WIDTH;
				placingQuadFront.alpha = 0.25;
				this.addChild(placingQuadFront);
				
				//y face
				var placingQuadTop:Quad = new Quad(Constant.BLOCK_WIDTH, -Constant.BLOCK_WIDTH*.615, placeable ? Color.GREEN : Color.RED);
				placingQuadTop.x = Constant.SUITCASE_OFFSET[orientation.y].x + (p.x)*Constant.BLOCK_WIDTH - zx_offset*(p.z);
				placingQuadTop.y = Constant.SUITCASE_OFFSET[orientation.y].y - (size.y)*Constant.BLOCK_WIDTH - zy_offset*(p.z) - Math.sin(Math.PI/24)*Constant.BLOCK_WIDTH*p.x;
				if(rotatedBag.x < 0) {
					placingQuadTop.y += Math.sin(Math.PI/24)*Constant.BLOCK_WIDTH;
				}
				placingQuadTop.skewX = -Math.PI/4;
				placingQuadTop.skewY = -Math.PI/24;
				placingQuadTop.alpha = 0.25;
				this.addChild(placingQuadTop);
				
				//z face
				var placingQuadLeft:Quad = new Quad(-Constant.BLOCK_WIDTH*.615, -Constant.BLOCK_WIDTH, placeable ? Color.GREEN : Color.RED);
				placingQuadLeft.x = Constant.SUITCASE_OFFSET[orientation.y].x - zx_offset*(p.z);
				placingQuadLeft.y = Constant.SUITCASE_OFFSET[orientation.y].y - (p.y)*Constant.BLOCK_WIDTH - zy_offset*(p.z);
				if (rotatedBag.x < 0) { 
					placingQuadLeft.x += (rotatedBag.x+1)*Constant.BLOCK_WIDTH;
					placingQuadLeft.y -= Math.sin(Math.PI/24)*Constant.BLOCK_WIDTH*rotatedBag.x;
				}
				placingQuadLeft.skewY =  Math.PI/4;
				placingQuadLeft.alpha = .25;
				this.addChild(placingQuadLeft);
				
			}
		}
		
		private function drawPlacedItem(item: Item) : void {
			var cameraMat:Matrix = new Matrix(0, Math.PI*orientation.y/2, 0);
			
			//green out quads where the item is being placed
			for (var x: int = 0; x < item.positionedSkeleton.length; x++) {
				//rotate this point
				var p:IntPoint = cameraMat.rotateInt(item.positionedSkeleton[x].point);
				var placeable:Boolean = item.positionedSkeleton[x].placeable;
				
				//x face
				var placingQuadFront:Quad = new Quad(Constant.BLOCK_WIDTH, -Constant.BLOCK_WIDTH, placeable ? Color.GREEN : Color.RED);
				placingQuadFront.x = Constant.SUITCASE_OFFSET[orientation.y].x + (p.x)*Constant.BLOCK_WIDTH;
				placingQuadFront.y = Constant.SUITCASE_OFFSET[orientation.y].y - p.y*Constant.BLOCK_WIDTH - Math.sin(Math.PI/24)*Constant.BLOCK_WIDTH*p.x;
				placingQuadFront.skewY = -Math.PI/24;
				if (rotatedBag.z < 0) {
					placingQuadFront.x -= zx_offset*(rotatedBag.z+1);
					placingQuadFront.y -= zy_offset*(rotatedBag.z+1);
				}
				if(rotatedBag.x < 0) placingQuadFront.y += Math.sin(Math.PI/24)*Constant.BLOCK_WIDTH;
				placingQuadFront.alpha = 0.25;
				this.addChild(placingQuadFront);
				
				//y face
				var placingQuadTop:Quad = new Quad(Constant.BLOCK_WIDTH, -Constant.BLOCK_WIDTH*.615, placeable ? Color.GREEN : Color.RED);
				placingQuadTop.x = Constant.SUITCASE_OFFSET[orientation.y].x + (p.x)*Constant.BLOCK_WIDTH - zx_offset*(p.z);
				placingQuadTop.y = Constant.SUITCASE_OFFSET[orientation.y].y - (size.y)*Constant.BLOCK_WIDTH - zy_offset*(p.z) - Math.sin(Math.PI/24)*Constant.BLOCK_WIDTH*p.x;
				if(rotatedBag.x < 0) {
					placingQuadTop.y += Math.sin(Math.PI/24)*Constant.BLOCK_WIDTH;
				}
				placingQuadTop.skewX = -Math.PI/4;
				placingQuadTop.skewY = -Math.PI/24;
				placingQuadTop.alpha = 0.25;
				this.addChild(placingQuadTop);
				
				//z face
				var placingQuadLeft:Quad = new Quad(-Constant.BLOCK_WIDTH*.615, -Constant.BLOCK_WIDTH, placeable ? Color.GREEN : Color.RED);
				placingQuadLeft.x = Constant.SUITCASE_OFFSET[orientation.y].x - zx_offset*(p.z);
				placingQuadLeft.y = Constant.SUITCASE_OFFSET[orientation.y].y - (p.y)*Constant.BLOCK_WIDTH - zy_offset*(p.z);
				if (rotatedBag.x < 0) { 
					placingQuadLeft.x += (rotatedBag.x+1)*Constant.BLOCK_WIDTH;
					placingQuadLeft.y -= Math.sin(Math.PI/24)*Constant.BLOCK_WIDTH*rotatedBag.x;
				}
				placingQuadLeft.skewY =  Math.PI/4;
				placingQuadLeft.alpha = .25;
				this.addChild(placingQuadLeft);
				
			}
		}
		
		public function rotateCamera(cameraOffset:Number) : void {
			orientation.y += (cameraOffset + 4);
			orientation.y = orientation.y%4;
						
			var cameraMat:Matrix = new Matrix(0, Math.PI*orientation.y/2, 0);
			rotatedBag = cameraMat.rotateInt(size);
			
			
			//rotate all the items while we're at it
			for (var i:int = 0; i < placedItems.length; i++)
				placedItems[i].rotateItem(new Point(0, cameraOffset*Math.PI/2, 0),0);
			for (var j:int = 0; j < queuedItems.length; j++)
				queuedItems[j].rotateItem(new Point(0, cameraOffset*Math.PI/2, 0),0);
		}
		
		public function moveItem(transPoint:IntPoint, rotPoint:Point) :void {
			
			if (queuedItems.length == 0)
				return;
			
			var item:Item = queuedItems[item_index];
			//make sure that this item is initialized
			if (!item.initialized) return;
			
			var cameraMat:Matrix = new Matrix(0, -Math.PI*orientation.y/2, 0);
			transPoint = cameraMat.rotateInt(transPoint);
			
			item.position.add(transPoint);
			
			var rotMat:Matrix = new Matrix(rotPoint.x, rotPoint.y, rotPoint.z);
			
			//var rotMat:Matrix = new Matrix (item.orientation.x, item.orientation.y, item.orientation.z);
			var minPoints:Point = new Point(0, 0, 0);
			var maxPoints:Point = new Point(0, 0, 0);
			var p:IntPoint;
			
			//rotate the skeleton - move it if it is out of bounds, otherwise just check it
			item.rotateItem(rotPoint,orientation.y);
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

		public function saved() :Boolean{
			for(var a:int = 1;a<4;a++){
				saveFile=SharedObject.getLocal("save"+a);
				if(saveFile.data.loaded==true){
					break;
				}
			}
			return saveFile.data.saved;
		}
		
		private function placesave(item:Item):void {
			var array1:Array=new Array();
			var posarray:Array=new Array();
			var oriarray:Array=new Array();
			if(saveFile.data.saved){
				saveArray=saveFile.data.placed;
				posarray=saveFile.data.position;
				oriarray=saveFile.data.orientation;
			}
			for (var i :int = 0; i < item.positionedSkeleton.length; i++) {
				//rotate point by current rotation and place it
				var p:IntPoint = item.positionedSkeleton[i].point;
				var array2:Array=new Array();
				//saving positioned skeleton to arrays
				array2.push(p.x,p.y,p.z);
				array1.push(array2);
			}
			saveArray.push(array1);
			saveFile.data.placed=saveArray;
			//save position and orientation for sprite drawing
			posarray.push(item.position.x,item.position.y,item.position.z);
			oriarray.push(item.orientation.x,item.position.y,item.position.z);
			saveFile.data.position=posarray;
			saveFile.data.orientation=oriarray;
			imgarray.push(item.getImage());
			saveFile.data.image=imgarray;
			nameArray.push(item.getPrefix());
			saveFile.data.names=nameArray;
			saveFile.data.saved=true;
			saveFile.flush();
		}

		public function Loadone() :void{
			//checks which items in queue match ones in save
			nameArray=saveFile.data.names;
			var removed:Array=new Array();
			for(var i:int=0;i<nameArray.length;i++){
				for(var j:int=0;j<queuedItems.length;j++){
					if(queuedItems[j].getPrefix()==nameArray[i]){
						if(j in removed){
							continue;
						}
						removed.push(j);
						item_index=j;
						moveItem(new IntPoint(0, 0, 0), new Point(0, 0, 0))
						Loadtwo(j,i);
						break;
					}
				}
			}
			removed.sort();
			for(var a:int=removed.length;a>0;a--)
			{
				queuedItems.splice(removed[a-1], 1);
			}
			item_index=0;
			moveItem(new IntPoint(0, 0, 0), new Point(0, 0, 0))
			addChild(queuedItems[item_index]);
			drawItem(queuedItems[item_index]);
			moveItem(new IntPoint(0, 0, 0), new Point(0, 0, 0))
		}

		public function Loadtwo(i:int,j:int):void{
			//loads the item variables
			var item:Item = queuedItems[i];
			var loadArray:Array=new Array();
			var imagenum:Array=new Array();
			loadArray=saveFile.data.placed
			imagenum=saveFile.data.image
			//item.positionedSkeleton = new Vector.<SkeletonPoint>();
			for (var k :int = 0; k < item.positionedSkeleton.length; k++) {
					var p:IntPoint=new IntPoint(loadArray[j][k][0],
						loadArray[j][k][1],
						loadArray[j][k][2])
					item.positionedSkeleton[k].point=p;
					contents[p.x][p.y][p.z] = true;
			}
			item.position.x=saveFile.data.position[3*j+0];
			item.position.y=saveFile.data.position[3*j+1];
			item.position.z=saveFile.data.position[3*j+2];
			item.orientation.x=saveFile.data.orientation[3*j+0];
			item.orientation.y=saveFile.data.orientation[3*j+1];
			item.orientation.z=saveFile.data.orientation[3*j+2];
			item.setImage(imagenum[j]);
			item.placed = true;
			placedItems.push(item);
		}
		
		public function processInput(e: KeyboardEvent) : String {
			if (!loaded) return null;
			
			var transPoint:IntPoint = new IntPoint(0, 0, 0);
			var rotPoint:Point = new Point(0, 0, 0);
			var cameraRotation:Number = 0;
			
			if (e.keyCode == Keyboard.TAB)
				cycleQueuedItem(1);
			
			if(e.keyCode == Keyboard.A)
				transPoint.x--;
			if (e.keyCode == Keyboard.D)
				transPoint.x++;
			if (e.keyCode == Keyboard.W)
				transPoint.z++;
			if (e.keyCode == Keyboard.S)
				transPoint.z--;
			
			//item rotation
			if (e.keyCode == Keyboard.NUMBER_1)
				rotPoint.x += Math.PI/2;
			if (e.keyCode == Keyboard.NUMBER_2)
				rotPoint.y -= Math.PI/2;
			if (e.keyCode == Keyboard.NUMBER_3)
				rotPoint.z += Math.PI/2;
			
			//camera rotation
			if (e.keyCode == Keyboard.Q){
				cameraRotation -= 1;
				rotateCamera(cameraRotation);
			}
			if (e.keyCode == Keyboard.E){
				cameraRotation += 1;
				rotateCamera(cameraRotation);
			}
			
			//item swapping
			if (e.keyCode == Keyboard.R) {
				swapStoredItem();
			}
			
			
			moveItem(transPoint, rotPoint);
			
			//place item
			if (e.keyCode == Keyboard.SPACE) {
				if (placeItem()) {
					if (done) {
						trace("You win");
						return VICTORY;
					}
				}
			}
			
			return null;
		}
	}
}