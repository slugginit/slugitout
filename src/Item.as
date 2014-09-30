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
		public var faces:Vector.<Face>;
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
		private var spritePrefix:String = null;
		
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
		
		public function addDispatcher(dispatcher:EventDispatcher):void {
			_dispatcher = dispatcher;
		}
		
		public function loadFile(filename:String):void {
			textLoader.load(new URLRequest(filename));
			textLoader.addEventListener(Event.COMPLETE, readFile);
		}
		
		
		private function readFile(e:Event):void {
			faces = new Vector.<Face>();
			
			var lines:Array = e.target.data.split(/\n/);
			//create faces
			var points:Vector.<IntPoint> = new Vector.<IntPoint>();
			
			for (var i:int = 0; i < lines.length; i++) {
				//create skeleton
				if (lines[i].charAt(0) == "$") {
					skeleton = points;
					points = new Vector.<IntPoint>();
					trace("Setting skeleton");
					continue;
				}
				
				var arr:Array = lines[i].split(" ");
				var p:IntPoint = new IntPoint(arr[0], arr[1], arr[2]);
				
				points.push(p);	
			}
			
			if (_dispatcher != null)
				_dispatcher.dispatchEvent(new Event("Loaded"));
			
			initialized = true;
			
		}
		
		public function drawObjectGuidelines(cameraRotation:Number, ySize:int, color:int):void {
			this.removeChildren(0, this.numChildren);
			
			var positionedSprite :PositionedSprite = new PositionedSprite(currentSprite, cameraRotation, position);
			trace("display queue position: " + position);
			DisplayQueue.addSprite(positionedSprite);
			
			/*
			var xx:int = Constant.SUITCASE_OFFSET[cameraRotation].x + position.x*Constant.BLOCK_WIDTH - zx_offset*position.z - 250;
			var yy:int = Constant.SUITCASE_OFFSET[cameraRotation].y - position.y*Constant.BLOCK_WIDTH - zy_offset*position.z - currentSprite.height + 125;
			
			
			trace("sprite position: " + xx + " " + yy + " postion: " + position.x + " " + position.y);
			currentSprite.x = xx;
			currentSprite.y = yy;
			this.addChild(currentSprite);
			*/
			
			var cameraMat:Matrix = new Matrix(0, Math.PI*cameraRotation/2, 0);
			
			
			//green out quads where the item is being placed
			for (var x: int = 0; x < positionedSkeleton.length; x++) {
				//rotate this point by camera rotation
				var p:IntPoint = cameraMat.rotateInt(positionedSkeleton[x].point);
				//trace("Rotating " + positionedSkeleton[x].point + " to " + p + " camera rotation: " + cameraRotation);
				var placeable:Boolean = positionedSkeleton[x].placeable;
				
				//x face
				var placingQuadFront:Quad = new Quad(Constant.BLOCK_WIDTH, -Constant.BLOCK_WIDTH, color);
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
			}
			
			
			
			//trace("Drawing item: position - " + position.toString() + " orientation - " + orientation.toString());
			/*
			for (var i:int; i < faces.length; i++) {
				faces[i].drawFace(cameraOffset,orientation, position, placed);
				this.addChild(faces[i]);
			}*/
		}

		public function rotateItem(rotPoint:Point):void {
			trace("Rotating object: " + rotPoint.toString());
			var mapping:ArtMapping = new ArtMapping();
			
			if (rotPoint.x > 0) {
				trace("Rotating " + imageIndex + " to " + ArtMapping.mappings[imageIndex][0]);
				imageIndex = ArtMapping.mappings[imageIndex][0];
			}
			if (rotPoint.y < 0) {
				trace("Rotating " + imageIndex + " to " + ArtMapping.mappings[imageIndex][1]);
				imageIndex = ArtMapping.mappings[imageIndex][1];
			}
			if (rotPoint.z > 0) {
				trace("Rotating " + imageIndex + " to " + ArtMapping.mappings[imageIndex][2]);
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

		
	}
	
}