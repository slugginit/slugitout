/**
 *
 * Hungry Hero Game
 * http://www.hungryherogame.com
 * 
 * Copyright (c) 2012 Hemanth Sharma (www.hsharma.com). All rights reserved.
 * 
 * This ActionScript source code is free.
 * You can redistribute and/or modify it in accordance with the
 * terms of the accompanying Simplified BSD License Agreement.
 *  
 */

package 
{
	import flash.display.Bitmap;
	import flash.utils.Dictionary;
	
	import starling.textures.Texture;
	import starling.textures.TextureAtlas;
	
	/**
	 * This class holds all embedded textures, fonts and sounds and other embedded files.  
	 * By using static access methods, only one instance of the asset file is instantiated. This 
	 * means that all Image types that use the same bitmap will use the same Texture on the video card.
	 * 
	 * @author hsharma
	 * 
	 */
	public class Assets
	{
		/**
		 * Texture Atlas 
		 */
		[Embed(source="../media/graphics/tsa.png")]
		public static const TSAWorker:Class;
		[Embed(source="../media/graphics/randomflag.png")]
		public static const flag:Class;
		
		/*[Embed(source="../media/graphics/mySpritesheet.xml", mimeType="application/octet-stream")]
		public static const AtlasXmlGame:Class;
		
		/**
		 * Background Assets 
		 */
		/*[Embed(source="../media/graphics/bgLayer1.jpg")]
		public static const BgLayer1:Class;
		*/
		[Embed(source="../media/graphics/background.png")]
		public static const BgWelcome:Class;
		
		[Embed(source="../media/graphics/bucket.png")]	
		public static const bucket:Class;
		
		[Embed(source="../media/graphics/belt.png")]	
		public static const belt:Class;
		
		[Embed(source="../media/graphics/score.png")]	
		public static const scoreimage:Class;
		
		/**
		 * Texture Cache 
		 */
		private static var gameTextures:Dictionary = new Dictionary();
		private static var gameTextureAtlas:TextureAtlas;
		
		/**
		 * Returns the Texture atlas instance.
		 * @return the TextureAtlas instance (there is only oneinstance per app)
		 *//*
		public static function getAtlas():TextureAtlas
		{
			if (gameTextureAtlas == null)
			{
				var texture:Texture = getTexture("AtlasTextureGame");
				var xml:XML = XML(new AtlasXmlGame());
				gameTextureAtlas=new TextureAtlas(texture, xml);
			}
			
			return gameTextureAtlas;
		}
		
		/**
		 * Returns a texture from this class based on a string key.
		 * 
		 * @param name A key that matches a static constant of Bitmap type.
		 * @return a starling texture.
		 */
		public static function getTexture(name:String):Texture
		{
			if (gameTextures[name] == undefined)
			{
				var bitmap:Bitmap = new Assets[name]();
				gameTextures[name]=Texture.fromBitmap(bitmap);
			}
			
			return gameTextures[name];
		}
		
		/**
		 * Images
		 */
		//cat pillow
		[Embed(source="../media/graphics/pillow/neckkittyFINAL_001.png")]
		public static const noodle0:Class;
		[Embed(source="../media/graphics/pillow/neckkittyFINAL_002.png")]
		public static const noodle1:Class;
		[Embed(source="../media/graphics/pillow/neckkittyFINAL_003.png")]
		public static const noodle2:Class;
		[Embed(source="../media/graphics/pillow/neckkittyFINAL_004.png")]
		public static const noodle3:Class;
		[Embed(source="../media/graphics/pillow/neckkittyFINAL_005.png")]
		public static const noodle4:Class;
		[Embed(source="../media/graphics/pillow/neckkittyFINAL_006.png")]
		public static const noodle5:Class;
		[Embed(source="../media/graphics/pillow/neckkittyFINAL_007.png")]
		public static const noodle6:Class;
		[Embed(source="../media/graphics/pillow/neckkittyFINAL_008.png")]
		public static const noodle7:Class;
		[Embed(source="../media/graphics/pillow/neckkittyFINAL_009.png")]
		public static const noodle8:Class;
		[Embed(source="../media/graphics/pillow/neckkittyFINAL_010.png")]
		public static const noodle9:Class;
		[Embed(source="../media/graphics/pillow/neckkittyFINAL_011.png")]
		public static const noodle10:Class;
		[Embed(source="../media/graphics/pillow/neckkittyFINAL_012.png")]
		public static const noodle11:Class;
		[Embed(source="../media/graphics/pillow/neckkittyFINAL_013.png")]
		public static const noodle12:Class;
		[Embed(source="../media/graphics/pillow/neckkittyFINAL_014.png")]
		public static const noodle13:Class;
		[Embed(source="../media/graphics/pillow/neckkittyFINAL_015.png")]
		public static const noodle14:Class;
		[Embed(source="../media/graphics/pillow/neckkittyFINAL_016.png")]
		public static const noodle15:Class;
		[Embed(source="../media/graphics/pillow/neckkittyFINAL_017.png")]
		public static const noodle16:Class;
		[Embed(source="../media/graphics/pillow/neckkittyFINAL_018.png")]
		public static const noodle17:Class;
		[Embed(source="../media/graphics/pillow/neckkittyFINAL_019.png")]
		public static const noodle18:Class;
		[Embed(source="../media/graphics/pillow/neckkittyFINAL_020.png")]
		public static const noodle19:Class;
		[Embed(source="../media/graphics/pillow/neckkittyFINAL_021.png")]
		public static const noodle20:Class;
		[Embed(source="../media/graphics/pillow/neckkittyFINAL_022.png")]
		public static const noodle21:Class;
		[Embed(source="../media/graphics/pillow/neckkittyFINAL_023.png")]
		public static const noodle22:Class;
		[Embed(source="../media/graphics/pillow/neckkittyFINAL_024.png")]
		public static const noodle23:Class;
		
		//sock
		[Embed(source="../media/graphics/sock/socks001.png")]
		public static const sock0:Class;
		[Embed(source="../media/graphics/sock/socks002.png")]
		public static const sock1:Class;
		[Embed(source="../media/graphics/sock/socks003.png")]
		public static const sock2:Class;
		[Embed(source="../media/graphics/sock/socks004.png")]
		public static const sock3:Class;
		[Embed(source="../media/graphics/sock/socks005.png")]
		public static const sock4:Class;
		[Embed(source="../media/graphics/sock/socks006.png")]
		public static const sock5:Class;
		[Embed(source="../media/graphics/sock/socks007.png")]
		public static const sock6:Class;
		[Embed(source="../media/graphics/sock/socks008.png")]
		public static const sock7:Class;
		[Embed(source="../media/graphics/sock/socks009.png")]
		public static const sock8:Class;
		[Embed(source="../media/graphics/sock/socks010.png")]
		public static const sock9:Class;
		[Embed(source="../media/graphics/sock/socks011.png")]
		public static const sock10:Class;
		[Embed(source="../media/graphics/sock/socks012.png")]
		public static const sock11:Class;
		[Embed(source="../media/graphics/sock/socks013.png")]
		public static const sock12:Class;
		[Embed(source="../media/graphics/sock/socks014.png")]
		public static const sock13:Class;
		[Embed(source="../media/graphics/sock/socks015.png")]
		public static const sock14:Class;
		[Embed(source="../media/graphics/sock/socks016.png")]
		public static const sock15:Class;
		[Embed(source="../media/graphics/sock/socks017.png")]
		public static const sock16:Class;
		[Embed(source="../media/graphics/sock/socks018.png")]
		public static const sock17:Class;
		[Embed(source="../media/graphics/sock/socks019.png")]
		public static const sock18:Class;
		[Embed(source="../media/graphics/sock/socks020.png")]
		public static const sock19:Class;
		[Embed(source="../media/graphics/sock/socks021.png")]
		public static const sock20:Class;
		[Embed(source="../media/graphics/sock/socks022.png")]
		public static const sock21:Class;
		[Embed(source="../media/graphics/sock/socks023.png")]
		public static const sock22:Class;
		[Embed(source="../media/graphics/sock/socks024.png")]
		public static const sock23:Class;
	}
}
