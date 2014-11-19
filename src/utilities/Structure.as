package utilities {

	public class Structure {
		public var size:IntPoint;
		public var contents:Vector.<Item> = new Vector.<Item>();
		
		public function Structure(s:IntPoint) {
			size = s;
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
		
		public function unloadObjects(position:IntPoint):Vector.<Item> {
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
	
	}
}