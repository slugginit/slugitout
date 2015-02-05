package {
	

	public class Constant {
		public static var ISOMETRIC_ANGLE : Number = 30.0*Math.PI/180.0;
		public static var BLOCK_WIDTH : Number = 75;
		public static var SUITCASE_OFFSET:Array;
		
		public static var ZX_OFFSET: Number = Math.cos(Constant.ISOMETRIC_ANGLE)*Constant.BLOCK_WIDTH*.5;
		public static var ZY_OFFSET: Number = Math.sin(Constant.ISOMETRIC_ANGLE)*Constant.BLOCK_WIDTH*.5;
		
		//return actions
		public static var NO_ACTION = -1;
		public static var EASY_GAME = 0;
		public static var NORMAL_GAME = 1;
		public static var HARD_GAME = 2;
		public static var VICTORY = 3;
		public static var RETIRE = 4;
		public static var RESUME = 5;
		public static var SAVE_QUIT = 6;
		public static var RESTART = 7;
		public static var NEXT_LEVEL = 8;
	}
}