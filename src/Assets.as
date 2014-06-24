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
		[Embed(source="../media/graphics/pillow/neckpillow_full001.png")]
		public static const noodle0:Class;
		[Embed(source="../media/graphics/pillow/neckpillow_full002.png")]
		public static const noodle1:Class;
		[Embed(source="../media/graphics/pillow/neckpillow_full003.png")]
		public static const noodle2:Class;
		[Embed(source="../media/graphics/pillow/neckpillow_full004.png")]
		public static const noodle3:Class;
		[Embed(source="../media/graphics/pillow/neckpillow_full005.png")]
		public static const noodle4:Class;
		[Embed(source="../media/graphics/pillow/neckpillow_full006.png")]
		public static const noodle5:Class;
		[Embed(source="../media/graphics/pillow/neckpillow_full007.png")]
		public static const noodle6:Class;
		[Embed(source="../media/graphics/pillow/neckpillow_full008.png")]
		public static const noodle7:Class;
		[Embed(source="../media/graphics/pillow/neckpillow_full009.png")]
		public static const noodle8:Class;
		[Embed(source="../media/graphics/pillow/neckpillow_full010.png")]
		public static const noodle9:Class;
		[Embed(source="../media/graphics/pillow/neckpillow_full011.png")]
		public static const noodle10:Class;
		[Embed(source="../media/graphics/pillow/neckpillow_full012.png")]
		public static const noodle11:Class;
		[Embed(source="../media/graphics/pillow/neckpillow_full013.png")]
		public static const noodle12:Class;
		[Embed(source="../media/graphics/pillow/neckpillow_full014.png")]
		public static const noodle13:Class;
		[Embed(source="../media/graphics/pillow/neckpillow_full015.png")]
		public static const noodle14:Class;
		[Embed(source="../media/graphics/pillow/neckpillow_full016.png")]
		public static const noodle15:Class;
		[Embed(source="../media/graphics/pillow/neckpillow_full017.png")]
		public static const noodle16:Class;
		[Embed(source="../media/graphics/pillow/neckpillow_full018.png")]
		public static const noodle17:Class;
		[Embed(source="../media/graphics/pillow/neckpillow_full019.png")]
		public static const noodle18:Class;
		[Embed(source="../media/graphics/pillow/neckpillow_full020.png")]
		public static const noodle19:Class;
		[Embed(source="../media/graphics/pillow/neckpillow_full021.png")]
		public static const noodle20:Class;
		[Embed(source="../media/graphics/pillow/neckpillow_full022.png")]
		public static const noodle21:Class;
		[Embed(source="../media/graphics/pillow/neckpillow_full023.png")]
		public static const noodle22:Class;
		[Embed(source="../media/graphics/pillow/neckpillow_full024.png")]
		public static const noodle23:Class;
		
	}
}
