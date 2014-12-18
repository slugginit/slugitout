package {
	import display.DisplayQueue;
	import display.PositionedSprite;
	
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	
	import starling.display.Image;
	import starling.display.Quad;
	import starling.display.Sprite;
	import starling.utils.Color;
	
	import utilities.ArtMapping;
	import utilities.IntPoint;
	import utilities.Matrix;
	import utilities.Point;
	import utilities.SkeletonPoint;

	public class Item extends Sprite {
		
		//store unique points as well as faces
		public var position:IntPoint;
		public var orientation:Point;
		public var rotatedPosition:IntPoint;
		
		public var skeleton:Vector.<IntPoint>;
		public var positionedSkeleton:Vector.<SkeletonPoint>;
		
		public var placed:Boolean = false;
		public var placeable:Boolean = false;
		public var initialized:Boolean = false;
		
		private var textLoader:URLLoader = new URLLoader();
		
		private var _dispatcher:EventDispatcher;
		
		private var imageIndex:int = 0;
		public var spritePrefix:String = null;
		
		private var currentSprite:Image = null;

		/**
		 * Constructor - pass filename to load sprites and points
		 */
		public function Item(prefix:String) {
			//just make it a straight thing for now
			orientation = new Point(0, 0, 0);
			position = new IntPoint(0, 0, 0);
			spritePrefix = prefix;
			currentSprite = new Image(Assets.getTexture(spritePrefix + imageIndex));
		}
		
		public function copyItemWithDispatcher(dispatcher:EventDispatcher):Item {
			var newItem:Item = new Item(spritePrefix);
			newItem.addDispatcher(dispatcher);
			if (skeleton != null) {
				newItem.skeleton = new Vector.<IntPoint>();
				for (var i:int = 0; i < skeleton.length; i++) {
					newItem.skeleton.push(new IntPoint(skeleton[i].x, skeleton[i].y, skeleton[i].z));
				}
				newItem.initialized = true;	
			}
			else {
				newItem.loadFile("../templates/" + spritePrefix + ".txt");
			}
			newItem.position = position.copy();
			newItem.orientation = orientation.copy();
			newItem.spritePrefix = spritePrefix;
			newItem.currentSprite = new Image(Assets.getTexture(spritePrefix + imageIndex));
			
			return newItem;
		}
		
		public function copyItem():Item {
			var newItem:Item = new Item(spritePrefix);
			if (skeleton != null) {
				newItem.skeleton = new Vector.<IntPoint>();
				for (var i:int = 0; i < skeleton.length; i++) {
					newItem.skeleton.push(new IntPoint(skeleton[i].x, skeleton[i].y, skeleton[i].z));
				}
				newItem.initialized = true;	
			}
			else {
				newItem.loadFile("../templates/" + spritePrefix + ".txt");
			}
			newItem.position = position.copy();
			newItem.orientation = orientation.copy();
			newItem.spritePrefix = spritePrefix;
			newItem.currentSprite = new Image(Assets.getTexture(spritePrefix + imageIndex));
			
			return newItem;
		}
		
		
		public function addDispatcher(dispatcher:EventDispatcher):void {
			_dispatcher = dispatcher;
		}
		
		public function loadFile(filename:String):void {
			textLoader.load(new URLRequest(filename));
			textLoader.addEventListener(Event.COMPLETE, readFile);
		}
		
		/*
		public function loadFileWithPosition(filename:String, pos:IntPoint, rot:Point):void {
			trace("Loading item " + filename + position + rot);
			var i:int = 0;
			for(i = 0; i < rot.x; i++) rotateItem(new Point(Math.PI/2, 0, 0));
			for(i = 0; i < rot.y; i++) rotateItem(new Point(0, -Math.PI/2, 0));
			for(i = 0; i < rot.z; i++) rotateItem(new Point(0, 0, Math.PI/2));
			
			orientation = new Point(rot.x*Math.PI/2, -rot.y*Math.PI/2, rot.z*Math.PI/2);
			position = pos;
			loadFile(filename);
		}*/
		
		
		private function readFile(e:Event):void {
			var lines:Array = e.target.data.split(/\n/);
			//create faces
			var points:Vector.<IntPoint> = new Vector.<IntPoint>();
			
			for (var i:int = 0; i < lines.length; i++) {
				//create skeleton
				if (lines[i].charAt(0) == "$") {
					skeleton = points;
					points = new Vector.<IntPoint>();
					//trace("Setting skeleton");
					continue;
				}
				
				var arr:Array = lines[i].split(" ");
				var p:IntPoint = new IntPoint(arr[0], arr[1], arr[2]);
				
				points.push(p);	
			}
			
			
			//if position and rotation were pre-set, perform transformations
			var rotMat:Matrix = new Matrix(orientation.x, orientation.y, orientation.z);
			positionedSkeleton = new Vector.<SkeletonPoint>();
			for (i = 0; i < skeleton.length; i++) {
				p = rotMat.rotateInt(skeleton[i]);
				skeleton[i] = new IntPoint(p.x, p.y, p.z);
				positionedSkeleton.push(new SkeletonPoint(skeleton[i]));
			}
			
			initialized = true;
			
			if (_dispatcher != null) {
				_dispatcher.dispatchEvent(new Event("Loaded"));
				trace("Broadcasting Loaded event from " + spritePrefix);	
			}
			
			
		}
		
		public function drawObjectGuidelines(cameraRotation:Number, ySize:int, color:int):void {
			this.removeChildren(0, this.numChildren);
			
			if(!initialized)
				return;
			
			var positionedSprite :PositionedSprite = new PositionedSprite(currentSprite, cameraRotation, position);
			//trace("display queue position: " + position + " initialized: " + initialized);
			DisplayQueue.addSprite(positionedSprite);
			
			/*
			var cameraMat:Matrix = new Matrix(0, Math.PI*cameraRotation/2, 0);
			
			
			//green out quads where the item is being placed
			for (var x: int = 0; x < positionedSkeleton.length; x++) {
				//rotate this point by camera rotation
				var p:IntPoint = cameraMat.rotateInt(positionedSkeleton[x].point);
				//trace("Rotating " + positionedSkeleton[x].point + " to " + p + " camera rotation: " + cameraRotation);
				var placeable:Boolean = positionedSkeleton[x].placeable;
				
				//x faced
				var placingQuadFront:Quad = new Quad(Constant.BLOCK_WIDTH, -Constant.BLOCK_WIDTH, color);
				placingQuadFront.skewX = -Math.PI/24;
				placingQuadFront.x = Constant.SUITCASE_OFFSET[cameraRotation].x + p.x*Constant.BLOCK_WIDTH - Constant.ZX_OFFSET*p.z;
				placingQuadFront.y = Constant.SUITCASE_OFFSET[cameraRotation].y - p.y*Constant.BLOCK_WIDTH - Constant.ZY_OFFSET*p.z;
				placingQuadFront.alpha = 0.25;
				this.addChild(placingQuadFront);
				
				//y face
				var placingQuadTop:Quad = new Quad(Constant.BLOCK_WIDTH, -Constant.BLOCK_WIDTH*.5, color);
				placingQuadTop.x = Constant.SUITCASE_OFFSET[cameraRotation].x + p.x*Constant.BLOCK_WIDTH - Constant.ZX_OFFSET*p.z;
				placingQuadTop.y = Constant.SUITCASE_OFFSET[cameraRotation].y - (p.y+1)*Constant.BLOCK_WIDTH - Constant.ZY_OFFSET*p.z;
				placingQuadTop.skewX = -(Math.PI/2 - Constant.ISOMETRIC_ANGLE);
				placingQuadTop.alpha = 0.25;
				this.addChild(placingQuadTop);
				
				//z face
				var placingQuadLeft:Quad = new Quad(-Constant.BLOCK_WIDTH*.5, -Constant.BLOCK_WIDTH, color);
				placingQuadLeft.x = Constant.SUITCASE_OFFSET[cameraRotation].x + p.x*Constant.BLOCK_WIDTH - Constant.ZX_OFFSET*p.z;
				placingQuadLeft.y = Constant.SUITCASE_OFFSET[cameraRotation].y - p.y*Constant.BLOCK_WIDTH - Constant.ZY_OFFSET*p.z;
				placingQuadLeft.skewY =  Constant.ISOMETRIC_ANGLE;
				placingQuadLeft.alpha = .25;
				this.addChild(placingQuadLeft);
			}*/
			
		}

		public function rotateItem(rotPoint:Point,suitcaserot:int):void {
			//trace("Rotating object " + spritePrefix + ": " + rotPoint.toString());
			var mapping:ArtMapping = new ArtMapping();
			var phold:int=0;
			
			switch (suitcaserot){
				case 0:
					break;
				case 1:
					phold=rotPoint.x;
					rotPoint.x=rotPoint.z;
					rotPoint.z=-phold;
					break;
				case 2:
					rotPoint.x = -rotPoint.x;
					rotPoint.z = -rotPoint.z;
					break;
				case 3:
					phold=rotPoint.x;
					rotPoint.x=-rotPoint.z;
					rotPoint.z=phold;
					break;
			}
			if (rotPoint.x > 0) {
				//trace("Rotating " + imageIndex + " to " + ArtMapping.mappings[imageIndex][0]);
				imageIndex = ArtMapping.mappings[imageIndex][0];
			}
			if (rotPoint.y < 0) {
				//trace("Rotating " + imageIndex + " to " + ArtMapping.mappings[imageIndex][1]);
				imageIndex = ArtMapping.mappings[imageIndex][1];
			}
			if (rotPoint.z > 0) {
				//trace("Rotating " + imageIndex + " to " + ArtMapping.mappings[imageIndex][2]);
				imageIndex = ArtMapping.mappings[imageIndex][2];
			}
			
			//if it's less than 0, we have do a reverse lookup
			if (rotPoint.x < 0) {
				for (var i:int = 0; i < ArtMapping.mappings.length; i++) {
					if (ArtMapping.mappings[i][0] == imageIndex) {
						imageIndex = i;
						break;
					}
				}
			}
			if (rotPoint.y > 0) {
				for (var k:int = 0; k < ArtMapping.mappings.length; k++) {
					if (ArtMapping.mappings[k][1] == imageIndex) {
						imageIndex = k;
						break;
					}
				}
			}
			if (rotPoint.z < 0) {
				for (var j:int = 0; j < ArtMapping.mappings.length; j++) {
					if (ArtMapping.mappings[j][2] == imageIndex) {
						imageIndex = j;
						break;
					}
				}
			}
			
			
			currentSprite = new Image(Assets.getTexture(spritePrefix + imageIndex));
			currentSprite.scaleX = .75;
			currentSprite.scaleY = .75;
		}

		public function getPrefix():String{
			return spritePrefix;
		}
		public function getImage():int{
			return this.imageIndex;
		}
		public function setImage(x:int):void{
			this.imageIndex=x;
			currentSprite = new Image(Assets.getTexture(spritePrefix + imageIndex));
			currentSprite.scaleX = .75;
			currentSprite.scaleY = .75;
			return;
		}
		
		public static function sort(a:Item, b:Item):int {
			if (a.spritePrefix < b.spritePrefix) return -1;
			else if (b.spritePrefix < a.spritePrefix) return 1;
			else if (a._dispatcher != null) return -1;
			else return 1;
		}
	}
	
}