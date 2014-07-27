package {
	

	public class Constant {
		public static var ISOMETRIC_ANGLE : Number = 30.0*Math.PI/180.0;
		public static var BLOCK_WIDTH : Number = 75;
		public static var SUITCASE_OFFSET:Array;
		
		public static var ZX_OFFSET: Number = Math.cos(Constant.ISOMETRIC_ANGLE)*Constant.BLOCK_WIDTH*.5;
		public static var ZY_OFFSET: Number = Math.sin(Constant.ISOMETRIC_ANGLE)*Constant.BLOCK_WIDTH*.5;
	}
}