package utilities {
	import flash.events.EventDispatcher;

	public class Structure {
		public var size:IntPoint;
		public var contents:Vector.<Item> = new Vector.<Item>();
		
		public function Structure(s:IntPoint) {
			size = s;
		}
		
		public function sortContents() {
			contents.sort(Item.sort);	
		}
		
		public function loadObject(objName:String, pos:IntPoint, rot:IntPoint):void {
			var item: Item = new Item(objName);
			item.loadFile("../templates/" + objName + ".txt");
			contents.push(item);
		}
		
		public function rotateStructure(rot:Point):void {
			var rotMat:Matrix = new Matrix(rot.x, rot.y, rot.z);
			size = rotMat.rotateInt(size);
			
			/*var p:IntPoint;
			
			for (var i:int = 0; i < contents.length; i++) {
				contents[i].rotateItem(rot);
				for (var k:int = 0; k < contents[i].skeleton.length; k++) {
					p = rotMat.rotateInt(contents[i].skeleton[k]);
					contents[i].skeleton[k] = p;
				}
			}*/
		}
		
		public function unloadObjectsWithDispatcher(_dispatcher:EventDispatcher) {
			var copiedItems:Vector.<Item> = new Vector.<Item>();
			var item:Item = contents[0].copyItemWithDispatcher(_dispatcher);
			copiedItems.push(item);
			
			for (var i:int = 1; i < contents.length; i++) {
				var item:Item = contents[i].copyItem();
				//item.position.add(position);
				copiedItems.push(item);
			}
			return copiedItems;
		}
		
		public function unloadObjects():Vector.<Item> {
			contents.sort(Item.sort);
			//create copies of our objects with updated positions
			var copiedItems:Vector.<Item> = new Vector.<Item>();
			for (var i:int = 0; i < contents.length; i++) {
				var item:Item = contents[i].copyItem();
				//item.position.add(position);
				copiedItems.push(item);
			}
			return copiedItems;
		}
	
		/*public function updatePosition(pos:IntPoint):void {
			for (var i:int = 0; i < contents.length; i++) { 
				contents[i].position.add(pos);
				trace("Updated position to " + contents[i].position.toString());
			}
		}*/
		
		public static function sort(a:Structure, b:Structure) {
			return a.contents[0].spritePrefix < b.contents[0].spritePrefix ? -1 : 1;
		}
	
	}
}