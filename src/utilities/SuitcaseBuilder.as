package utilities {
	import flash.events.Event;
	import flash.geom.Rectangle;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	
	import utilities.IntPoint;
	import utilities.Structure;
	
	import flash.events.EventDispatcher;

	public class SuitcaseBuilder {
		private var fileName: String = "../rectangles.txt";
		private var textLoader:URLLoader = new URLLoader();
		private var rectangles:Vector.<Structure>;
		
		private var initialized = false;
		private var dispatcher:EventDispatcher;
		
		public function SuitcaseBuilder(_dispatcher:EventDispatcher):void {
			rectangles = new Vector.<Structure>();
			dispatcher = _dispatcher;
			
			//trace("Preparing to read file");
			
			//read in files
			textLoader.load(new URLRequest(fileName));
			textLoader.addEventListener(Event.COMPLETE, readFile);
			
		}
		
		private function readFile(e:Event): void {
			//trace("Loading rectangles file completed - reading");
			rectangles = new Vector.<Structure>();
			var lines:Array = e.target.data.split(/\n/);
			
			var size:IntPoint = new IntPoint(0, 0, 0);
			for (var i:int = 0; i < lines.length; i++) {
				//size line
				var sizeLine:Array = lines[i].split("x");
				size = new IntPoint(sizeLine[0], sizeLine[1], sizeLine[2]);
				var struct:Structure = new Structure(size);
				i++;
				
				//item lines
				while(i < lines.length && lines[i].length > 1) {
					var itemLine:Array = lines[i].split(" ");
					var pos:IntPoint = new IntPoint(0, 0, 0);
					pos.fromString(itemLine[1]);
					var rot:IntPoint = new IntPoint(0, 0, 0);
					rot.fromString(itemLine[2]);
					struct.loadObject(itemLine[0], pos, rot);
					i++;
					
				}
				
				rectangles.push(struct);
				//trace("Adding object of size: " + size);
			}
			
			dispatcher.dispatchEvent(new Event("BuilderLoaded"));
		}
		
		//find the first valid rectangle furthest left - returns Rect for where it starts and what size it is
		private function identifySubRectangle(layer:Array): Rectangle {
			var rect:Rectangle = null;
			
			for(var z: int = 0; z < layer[0].length; z++) {
				for(var x: int = 0; x < layer.length; x++) {
					if (layer[x][z] == false) {
						//make a rectangle starting here and count how big it can be
						rect = new Rectangle();
						rect.x = x;
						rect.y = z;
						//feel forward until you hit the edge for x and z to determine width and height
						var width:int = 0, height:int = 0;
						while(x + width < layer.length && layer[x + width][z] == false)
							width++;
						while(z + height < layer[0].length && layer[x][z + height] == false)
							height++;
						
						rect.width = width;
						rect.height = height;
						//trace("Found rectangle: pos: (" + rect.x + ", " + rect.y + ") size: (" + rect.width + ", " + rect.height + ")"); 
						break;
					}
				}
				//break if we've already found a rectangle
				if (rect != null) break;
			}
			
			//if (rect == null) trace("Returning null rect");
			
			return rect;
		}
		
		private function findStructure(rect:Rectangle, ySize:int, layer:Array, ceiling:int):Structure {
			var subsetRects:Vector.<Structure> = new Vector.<Structure>();
			//trace("Find Structure -  ySize: " + ySize + " ceiling: " + ceiling + " rectangles: " + rectangles.length);
			//if ySize is 0, just pick any struct with height less than the ceiling
			if(ySize == 0) {
				for (var k:int = 0; k < rectangles.length; k++) {
					var size:IntPoint = rectangles[k].size;
					if (size.y <= ceiling)
						subsetRects.push(rectangles[k]);
					else if (size.x <= ceiling) {
						var rotMat:Matrix = new Matrix(Math.PI/2, 0, 0);
						size = rotMat.rotateInt(size);
						size.toAbs();
						rectangles[k].size = size;
						subsetRects.push(rectangles[k]);
					}
					else if (size.z <= ceiling) {
						var rotMat:Matrix = new Matrix(0, 0, Math.PI/2);
						size = rotMat.rotateInt(size);
						size.toAbs();
						rectangles[k].size = size;
						subsetRects.push(rectangles[k]);
					}
				}
			}
			else {
				for (var i:int = 0; i < rectangles.length; i++) {
					//if we can get y to be correct - see if this block will fit
					var size:IntPoint = rectangles[i].size;
					if (size.x == ySize || size.y == ySize || size.z == ySize) {
						//rotate so y is correct size
						if (size.x == ySize) {
							var rotMat:Matrix = new Matrix(Math.PI/2, 0, 0);
							size = rotMat.rotateInt(size);
							size.toAbs();
						}
						if (size.z == ySize) {
							var rotMat:Matrix = new Matrix(0, 0, Math.PI/2);
							size = rotMat.rotateInt(size);
							size.toAbs();
						}
						
						if (size.x <= rect.width && size.z <= rect.height) {
							rectangles[i].size = size;
							subsetRects.push(rectangles[i]);
						}
						else if (size.z <= rect.width && size.x <= rect.height) {
							var rotMat:Matrix = new Matrix(0, -Math.PI/2, 0);
							size = rotMat.rotateInt(size);
							size.toAbs();
							rectangles[i].size = size;
							subsetRects.push(rectangles[i]);
						}
					}
				}
				
			}
			
			var chosenStruct:Structure = null;
			var chosenSize:IntPoint = new IntPoint(rect.width, 0, rect.height);
			//trace("Found " + subsetRects.length + " potential structures.");
			if (subsetRects.length > 0) {
				var index:int = Math.random()*subsetRects.length;
				chosenStruct = subsetRects[index];
				chosenSize = chosenStruct.size;
			}
			
			//trace("filling array " + chosenSize);
			//color array where new block is going
			for (var x:int = 0; x < chosenSize.x; x++) {
				for (var z:int = 0; z < chosenSize.z; z++)
					layer[rect.x + x][rect.y + z] = true;
			}
			
			return chosenStruct;
		}
		
		public function constructSuitcase(size:IntPoint):Vector.<Item> {
			
			var ceiling:int = size.y;
			
			var suitcaseContents:Vector.<Item> = new Vector.<Item>();
			
			while(ceiling > 0) {
				//reset layer array
				var layer:Array = new Array(size.x);
				for(var x: int = 0; x < layer.length; x++) {
					layer[x] = new Array(size.z);
					for (var z:int = 0; z < size.z; z++)
						layer[x][z] = false;
				}
				
				var rectSize:Rectangle;
				var ySize:int = 0;
				//trace("Filling a new layer, ceiling: " + ceiling);
				while ((rectSize = identifySubRectangle(layer)) != null) {
					var struct:Structure = findStructure(rectSize, ySize, layer, ceiling);
					//print layer for debugging
					//trace("LAYER");
					for (x = 0; x < layer.length; x++) {
						var s:String = "";
						for (z = 0; z < size.z; z++)
							s += layer[x][z] == false ? "-" : "x";
						//trace("\t" + s);	
					}
					
					//if it's null we couldn't fill this sub-rectangle
					if (struct == null) continue;
					//trace("\tFound struct of size " + struct.size);
					ySize = struct.size.y;
					
					var updatedPosition:IntPoint = new IntPoint(rectSize.x, size.y - ceiling, rectSize.y);
					//trace("Update position: " + updatedPosition.toString());
					
					var copiedContents:Vector.<Item> = !initialized ? struct.unloadObjectsWithDispatcher(dispatcher) : struct.unloadObjects(updatedPosition);
					
					for(var i:int = 0; i < copiedContents.length; i++) {
						trace("Adding " + copiedContents[i].spritePrefix);
						suitcaseContents.push(copiedContents[i]);
					}

				}
				
				ceiling -= ySize;
				//trace("Ceiling : " + ceiling);
			}
			
			trace("Filled suitcase with " + suitcaseContents.length + " items.");
						
			return suitcaseContents;
		}
		

		
	}
}