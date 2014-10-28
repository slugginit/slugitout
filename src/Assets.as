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
		[Embed(source="../media/graphics/play.png")]
		public static const play:Class;
		[Embed(source="../media/graphics/continue.png")]
		public static const cont:Class;
		[Embed(source="../media/graphics/back.png")]
		public static const backbtn:Class;
		[Embed(source="../media/graphics/help.png")]
		public static const helpbtn:Class;
		[Embed(source="../media/graphics/quit.png")]
		public static const quitbtn:Class;
		
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
		[Embed(source="../media/graphics/pillow/neckkittyFINAL_000.png")]
		public static const noodle0:Class;
		[Embed(source="../media/graphics/pillow/neckkittyFINAL_001.png")]
		public static const noodle1:Class;
		[Embed(source="../media/graphics/pillow/neckkittyFINAL_002.png")]
		public static const noodle2:Class;
		[Embed(source="../media/graphics/pillow/neckkittyFINAL_003.png")]
		public static const noodle3:Class;
		[Embed(source="../media/graphics/pillow/neckkittyFINAL_004.png")]
		public static const noodle4:Class;
		[Embed(source="../media/graphics/pillow/neckkittyFINAL_005.png")]
		public static const noodle5:Class;
		[Embed(source="../media/graphics/pillow/neckkittyFINAL_006.png")]
		public static const noodle6:Class;
		[Embed(source="../media/graphics/pillow/neckkittyFINAL_007.png")]
		public static const noodle7:Class;
		[Embed(source="../media/graphics/pillow/neckkittyFINAL_008.png")]
		public static const noodle8:Class;
		[Embed(source="../media/graphics/pillow/neckkittyFINAL_009.png")]
		public static const noodle9:Class;
		[Embed(source="../media/graphics/pillow/neckkittyFINAL_010.png")]
		public static const noodle10:Class;
		[Embed(source="../media/graphics/pillow/neckkittyFINAL_011.png")]
		public static const noodle11:Class;
		[Embed(source="../media/graphics/pillow/neckkittyFINAL_012.png")]
		public static const noodle12:Class;
		[Embed(source="../media/graphics/pillow/neckkittyFINAL_013.png")]
		public static const noodle13:Class;
		[Embed(source="../media/graphics/pillow/neckkittyFINAL_014.png")]
		public static const noodle14:Class;
		[Embed(source="../media/graphics/pillow/neckkittyFINAL_015.png")]
		public static const noodle15:Class;
		[Embed(source="../media/graphics/pillow/neckkittyFINAL_016.png")]
		public static const noodle16:Class;
		[Embed(source="../media/graphics/pillow/neckkittyFINAL_017.png")]
		public static const noodle17:Class;
		[Embed(source="../media/graphics/pillow/neckkittyFINAL_018.png")]
		public static const noodle18:Class;
		[Embed(source="../media/graphics/pillow/neckkittyFINAL_019.png")]
		public static const noodle19:Class;
		[Embed(source="../media/graphics/pillow/neckkittyFINAL_020.png")]
		public static const noodle20:Class;
		[Embed(source="../media/graphics/pillow/neckkittyFINAL_021.png")]
		public static const noodle21:Class;
		[Embed(source="../media/graphics/pillow/neckkittyFINAL_022.png")]
		public static const noodle22:Class;
		[Embed(source="../media/graphics/pillow/neckkittyFINAL_023.png")]
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
		
		[Embed(source="../media/graphics/boot/stripperboot_PH_001.png")]
		public static const boot0:Class;
		[Embed(source="../media/graphics/boot/stripperboot_PH_002.png")]
		public static const boot1:Class;
		[Embed(source="../media/graphics/boot/stripperboot_PH_003.png")]
		public static const boot2:Class;
		[Embed(source="../media/graphics/boot/stripperboot_PH_004.png")]
		public static const boot3:Class;
		[Embed(source="../media/graphics/boot/stripperboot_PH_005.png")]
		public static const boot4:Class;
		[Embed(source="../media/graphics/boot/stripperboot_PH_006.png")]
		public static const boot5:Class;
		[Embed(source="../media/graphics/boot/stripperboot_PH_007.png")]
		public static const boot6:Class;
		[Embed(source="../media/graphics/boot/stripperboot_PH_008.png")]
		public static const boot7:Class;
		[Embed(source="../media/graphics/boot/stripperboot_PH_009.png")]
		public static const boot8:Class;
		[Embed(source="../media/graphics/boot/stripperboot_PH_010.png")]
		public static const boot9:Class;
		[Embed(source="../media/graphics/boot/stripperboot_PH_011.png")]
		public static const boot10:Class;
		[Embed(source="../media/graphics/boot/stripperboot_PH_012.png")]
		public static const boot11:Class;
		[Embed(source="../media/graphics/boot/stripperboot_PH_013.png")]
		public static const boot12:Class;
		[Embed(source="../media/graphics/boot/stripperboot_PH_014.png")]
		public static const boot13:Class;
		[Embed(source="../media/graphics/boot/stripperboot_PH_015.png")]
		public static const boot14:Class;
		[Embed(source="../media/graphics/boot/stripperboot_PH_016.png")]
		public static const boot15:Class;
		[Embed(source="../media/graphics/boot/stripperboot_PH_017.png")]
		public static const boot16:Class;
		[Embed(source="../media/graphics/boot/stripperboot_PH_018.png")]
		public static const boot17:Class;
		[Embed(source="../media/graphics/boot/stripperboot_PH_019.png")]
		public static const boot18:Class;
		[Embed(source="../media/graphics/boot/stripperboot_PH_020.png")]
		public static const boot19:Class;
		[Embed(source="../media/graphics/boot/stripperboot_PH_021.png")]
		public static const boot20:Class;
		[Embed(source="../media/graphics/boot/stripperboot_PH_022.png")]
		public static const boot21:Class;
		[Embed(source="../media/graphics/boot/stripperboot_PH_023.png")]
		public static const boot22:Class;
		[Embed(source="../media/graphics/boot/stripperboot_PH_024.png")]
		public static const boot23:Class;
		
		[Embed(source="../media/graphics/bottle/waterbottle_PH_001.png")]
		public static const bottle0:Class;
		[Embed(source="../media/graphics/bottle/waterbottle_PH_002.png")]
		public static const bottle1:Class;
		[Embed(source="../media/graphics/bottle/waterbottle_PH_003.png")]
		public static const bottle2:Class;
		[Embed(source="../media/graphics/bottle/waterbottle_PH_004.png")]
		public static const bottle3:Class;
		[Embed(source="../media/graphics/bottle/waterbottle_PH_005.png")]
		public static const bottle4:Class;
		[Embed(source="../media/graphics/bottle/waterbottle_PH_006.png")]
		public static const bottle5:Class;
		[Embed(source="../media/graphics/bottle/waterbottle_PH_007.png")]
		public static const bottle6:Class;
		[Embed(source="../media/graphics/bottle/waterbottle_PH_008.png")]
		public static const bottle7:Class;
		[Embed(source="../media/graphics/bottle/waterbottle_PH_009.png")]
		public static const bottle8:Class;
		[Embed(source="../media/graphics/bottle/waterbottle_PH_010.png")]
		public static const bottle9:Class;
		[Embed(source="../media/graphics/bottle/waterbottle_PH_011.png")]
		public static const bottle10:Class;
		[Embed(source="../media/graphics/bottle/waterbottle_PH_012.png")]
		public static const bottle11:Class;
		[Embed(source="../media/graphics/bottle/waterbottle_PH_013.png")]
		public static const bottle12:Class;
		[Embed(source="../media/graphics/bottle/waterbottle_PH_014.png")]
		public static const bottle13:Class;
		[Embed(source="../media/graphics/bottle/waterbottle_PH_015.png")]
		public static const bottle14:Class;
		[Embed(source="../media/graphics/bottle/waterbottle_PH_016.png")]
		public static const bottle15:Class;
		[Embed(source="../media/graphics/bottle/waterbottle_PH_017.png")]
		public static const bottle16:Class;
		[Embed(source="../media/graphics/bottle/waterbottle_PH_018.png")]
		public static const bottle17:Class;
		[Embed(source="../media/graphics/bottle/waterbottle_PH_019.png")]
		public static const bottle18:Class;
		[Embed(source="../media/graphics/bottle/waterbottle_PH_020.png")]
		public static const bottle19:Class;
		[Embed(source="../media/graphics/bottle/waterbottle_PH_021.png")]
		public static const bottle20:Class;
		[Embed(source="../media/graphics/bottle/waterbottle_PH_022.png")]
		public static const bottle21:Class;
		[Embed(source="../media/graphics/bottle/waterbottle_PH_023.png")]
		public static const bottle22:Class;
		[Embed(source="../media/graphics/bottle/waterbottle_PH_024.png")]
		public static const bottle23:Class;
		
		[Embed(source="../media/graphics/camera/camera_PH_001.png")]
		public static const camera0:Class;
		[Embed(source="../media/graphics/camera/camera_PH_002.png")]
		public static const camera1:Class;
		[Embed(source="../media/graphics/camera/camera_PH_003.png")]
		public static const camera2:Class;
		[Embed(source="../media/graphics/camera/camera_PH_004.png")]
		public static const camera3:Class;
		[Embed(source="../media/graphics/camera/camera_PH_005.png")]
		public static const camera4:Class;
		[Embed(source="../media/graphics/camera/camera_PH_006.png")]
		public static const camera5:Class;
		[Embed(source="../media/graphics/camera/camera_PH_007.png")]
		public static const camera6:Class;
		[Embed(source="../media/graphics/camera/camera_PH_008.png")]
		public static const camera7:Class;
		[Embed(source="../media/graphics/camera/camera_PH_009.png")]
		public static const camera8:Class;
		[Embed(source="../media/graphics/camera/camera_PH_010.png")]
		public static const camera9:Class;
		[Embed(source="../media/graphics/camera/camera_PH_011.png")]
		public static const camera10:Class;
		[Embed(source="../media/graphics/camera/camera_PH_012.png")]
		public static const camera11:Class;
		[Embed(source="../media/graphics/camera/camera_PH_013.png")]
		public static const camera12:Class;
		[Embed(source="../media/graphics/camera/camera_PH_014.png")]
		public static const camera13:Class;
		[Embed(source="../media/graphics/camera/camera_PH_015.png")]
		public static const camera14:Class;
		[Embed(source="../media/graphics/camera/camera_PH_016.png")]
		public static const camera15:Class;
		[Embed(source="../media/graphics/camera/camera_PH_017.png")]
		public static const camera16:Class;
		[Embed(source="../media/graphics/camera/camera_PH_018.png")]
		public static const camera17:Class;
		[Embed(source="../media/graphics/camera/camera_PH_019.png")]
		public static const camera18:Class;
		[Embed(source="../media/graphics/camera/camera_PH_020.png")]
		public static const camera19:Class;
		[Embed(source="../media/graphics/camera/camera_PH_021.png")]
		public static const camera20:Class;
		[Embed(source="../media/graphics/camera/camera_PH_022.png")]
		public static const camera21:Class;
		[Embed(source="../media/graphics/camera/camera_PH_023.png")]
		public static const camera22:Class;
		[Embed(source="../media/graphics/camera/camera_PH_024.png")]
		public static const camera23:Class;
		
		[Embed(source="../media/graphics/doll/animething_PL_001.png")]
		public static const doll0:Class;
		[Embed(source="../media/graphics/doll/animething_PL_002.png")]
		public static const doll1:Class;
		[Embed(source="../media/graphics/doll/animething_PL_003.png")]
		public static const doll2:Class;
		[Embed(source="../media/graphics/doll/animething_PL_004.png")]
		public static const doll3:Class;
		[Embed(source="../media/graphics/doll/animething_PL_005.png")]
		public static const doll4:Class;
		[Embed(source="../media/graphics/doll/animething_PL_006.png")]
		public static const doll5:Class;
		[Embed(source="../media/graphics/doll/animething_PL_007.png")]
		public static const doll6:Class;
		[Embed(source="../media/graphics/doll/animething_PL_008.png")]
		public static const doll7:Class;
		[Embed(source="../media/graphics/doll/animething_PL_009.png")]
		public static const doll8:Class;
		[Embed(source="../media/graphics/doll/animething_PL_010.png")]
		public static const doll9:Class;
		[Embed(source="../media/graphics/doll/animething_PL_011.png")]
		public static const doll10:Class;
		[Embed(source="../media/graphics/doll/animething_PL_012.png")]
		public static const doll11:Class;
		[Embed(source="../media/graphics/doll/animething_PL_013.png")]
		public static const doll12:Class;
		[Embed(source="../media/graphics/doll/animething_PL_014.png")]
		public static const doll13:Class;
		[Embed(source="../media/graphics/doll/animething_PL_015.png")]
		public static const doll14:Class;
		[Embed(source="../media/graphics/doll/animething_PL_016.png")]
		public static const doll15:Class;
		[Embed(source="../media/graphics/doll/animething_PL_017.png")]
		public static const doll16:Class;
		[Embed(source="../media/graphics/doll/animething_PL_018.png")]
		public static const doll17:Class;
		[Embed(source="../media/graphics/doll/animething_PL_019.png")]
		public static const doll18:Class;
		[Embed(source="../media/graphics/doll/animething_PL_020.png")]
		public static const doll19:Class;
		[Embed(source="../media/graphics/doll/animething_PL_021.png")]
		public static const doll20:Class;
		[Embed(source="../media/graphics/doll/animething_PL_022.png")]
		public static const doll21:Class;
		[Embed(source="../media/graphics/doll/animething_PL_023.png")]
		public static const doll22:Class;
		[Embed(source="../media/graphics/doll/animething_PL_024.png")]
		public static const doll23:Class;
		
		[Embed(source="../media/graphics/hairdryer/hairdryer_PH_001.png")]
		public static const hairdryer0:Class;
		[Embed(source="../media/graphics/hairdryer/hairdryer_PH_002.png")]
		public static const hairdryer1:Class;
		[Embed(source="../media/graphics/hairdryer/hairdryer_PH_003.png")]
		public static const hairdryer2:Class;
		[Embed(source="../media/graphics/hairdryer/hairdryer_PH_004.png")]
		public static const hairdryer3:Class;
		[Embed(source="../media/graphics/hairdryer/hairdryer_PH_005.png")]
		public static const hairdryer4:Class;
		[Embed(source="../media/graphics/hairdryer/hairdryer_PH_006.png")]
		public static const hairdryer5:Class;
		[Embed(source="../media/graphics/hairdryer/hairdryer_PH_007.png")]
		public static const hairdryer6:Class;
		[Embed(source="../media/graphics/hairdryer/hairdryer_PH_008.png")]
		public static const hairdryer7:Class;
		[Embed(source="../media/graphics/hairdryer/hairdryer_PH_009.png")]
		public static const hairdryer8:Class;
		[Embed(source="../media/graphics/hairdryer/hairdryer_PH_010.png")]
		public static const hairdryer9:Class;
		[Embed(source="../media/graphics/hairdryer/hairdryer_PH_011.png")]
		public static const hairdryer10:Class;
		[Embed(source="../media/graphics/hairdryer/hairdryer_PH_012.png")]
		public static const hairdryer11:Class;
		[Embed(source="../media/graphics/hairdryer/hairdryer_PH_013.png")]
		public static const hairdryer12:Class;
		[Embed(source="../media/graphics/hairdryer/hairdryer_PH_014.png")]
		public static const hairdryer13:Class;
		[Embed(source="../media/graphics/hairdryer/hairdryer_PH_015.png")]
		public static const hairdryer14:Class;
		[Embed(source="../media/graphics/hairdryer/hairdryer_PH_016.png")]
		public static const hairdryer15:Class;
		[Embed(source="../media/graphics/hairdryer/hairdryer_PH_017.png")]
		public static const hairdryer16:Class;
		[Embed(source="../media/graphics/hairdryer/hairdryer_PH_018.png")]
		public static const hairdryer17:Class;
		[Embed(source="../media/graphics/hairdryer/hairdryer_PH_019.png")]
		public static const hairdryer18:Class;
		[Embed(source="../media/graphics/hairdryer/hairdryer_PH_020.png")]
		public static const hairdryer19:Class;
		[Embed(source="../media/graphics/hairdryer/hairdryer_PH_021.png")]
		public static const hairdryer20:Class;
		[Embed(source="../media/graphics/hairdryer/hairdryer_PH_022.png")]
		public static const hairdryer21:Class;
		[Embed(source="../media/graphics/hairdryer/hairdryer_PH_023.png")]
		public static const hairdryer22:Class;
		[Embed(source="../media/graphics/hairdryer/hairdryer_PH_024.png")]
		public static const hairdryer23:Class;
		
		[Embed(source="../media/graphics/handcuffs/handcuffs_PH_001.png")]
		public static const handcuffs0:Class;
		[Embed(source="../media/graphics/handcuffs/handcuffs_PH_002.png")]
		public static const handcuffs1:Class;
		[Embed(source="../media/graphics/handcuffs/handcuffs_PH_003.png")]
		public static const handcuffs2:Class;
		[Embed(source="../media/graphics/handcuffs/handcuffs_PH_004.png")]
		public static const handcuffs3:Class;
		[Embed(source="../media/graphics/handcuffs/handcuffs_PH_005.png")]
		public static const handcuffs4:Class;
		[Embed(source="../media/graphics/handcuffs/handcuffs_PH_006.png")]
		public static const handcuffs5:Class;
		[Embed(source="../media/graphics/handcuffs/handcuffs_PH_007.png")]
		public static const handcuffs6:Class;
		[Embed(source="../media/graphics/handcuffs/handcuffs_PH_008.png")]
		public static const handcuffs7:Class;
		[Embed(source="../media/graphics/handcuffs/handcuffs_PH_009.png")]
		public static const handcuffs8:Class;
		[Embed(source="../media/graphics/handcuffs/handcuffs_PH_010.png")]
		public static const handcuffs9:Class;
		[Embed(source="../media/graphics/handcuffs/handcuffs_PH_011.png")]
		public static const handcuffs10:Class;
		[Embed(source="../media/graphics/handcuffs/handcuffs_PH_012.png")]
		public static const handcuffs11:Class;
		[Embed(source="../media/graphics/handcuffs/handcuffs_PH_013.png")]
		public static const handcuffs12:Class;
		[Embed(source="../media/graphics/handcuffs/handcuffs_PH_014.png")]
		public static const handcuffs13:Class;
		[Embed(source="../media/graphics/handcuffs/handcuffs_PH_015.png")]
		public static const handcuffs14:Class;
		[Embed(source="../media/graphics/handcuffs/handcuffs_PH_016.png")]
		public static const handcuffs15:Class;
		[Embed(source="../media/graphics/handcuffs/handcuffs_PH_017.png")]
		public static const handcuffs16:Class;
		[Embed(source="../media/graphics/handcuffs/handcuffs_PH_018.png")]
		public static const handcuffs17:Class;
		[Embed(source="../media/graphics/handcuffs/handcuffs_PH_019.png")]
		public static const handcuffs18:Class;
		[Embed(source="../media/graphics/handcuffs/handcuffs_PH_020.png")]
		public static const handcuffs19:Class;
		[Embed(source="../media/graphics/handcuffs/handcuffs_PH_021.png")]
		public static const handcuffs20:Class;
		[Embed(source="../media/graphics/handcuffs/handcuffs_PH_022.png")]
		public static const handcuffs21:Class;
		[Embed(source="../media/graphics/handcuffs/handcuffs_PH_023.png")]
		public static const handcuffs22:Class;
		[Embed(source="../media/graphics/handcuffs/handcuffs_PH_024.png")]
		public static const handcuffs23:Class;
		
		[Embed(source="../media/graphics/money/moneydrugs_PH_001.png")]
		public static const money0:Class;
		[Embed(source="../media/graphics/money/moneydrugs_PH_002.png")]
		public static const money1:Class;
		[Embed(source="../media/graphics/money/moneydrugs_PH_003.png")]
		public static const money2:Class;
		[Embed(source="../media/graphics/money/moneydrugs_PH_004.png")]
		public static const money3:Class;
		[Embed(source="../media/graphics/money/moneydrugs_PH_005.png")]
		public static const money4:Class;
		[Embed(source="../media/graphics/money/moneydrugs_PH_006.png")]
		public static const money5:Class;
		[Embed(source="../media/graphics/money/moneydrugs_PH_007.png")]
		public static const money6:Class;
		[Embed(source="../media/graphics/money/moneydrugs_PH_008.png")]
		public static const money7:Class;
		[Embed(source="../media/graphics/money/moneydrugs_PH_009.png")]
		public static const money8:Class;
		[Embed(source="../media/graphics/money/moneydrugs_PH_010.png")]
		public static const money9:Class;
		[Embed(source="../media/graphics/money/moneydrugs_PH_011.png")]
		public static const money10:Class;
		[Embed(source="../media/graphics/money/moneydrugs_PH_012.png")]
		public static const money11:Class;
		[Embed(source="../media/graphics/money/moneydrugs_PH_013.png")]
		public static const money12:Class;
		[Embed(source="../media/graphics/money/moneydrugs_PH_014.png")]
		public static const money13:Class;
		[Embed(source="../media/graphics/money/moneydrugs_PH_015.png")]
		public static const money14:Class;
		[Embed(source="../media/graphics/money/moneydrugs_PH_016.png")]
		public static const money15:Class;
		[Embed(source="../media/graphics/money/moneydrugs_PH_017.png")]
		public static const money16:Class;
		[Embed(source="../media/graphics/money/moneydrugs_PH_018.png")]
		public static const money17:Class;
		[Embed(source="../media/graphics/money/moneydrugs_PH_019.png")]
		public static const money18:Class;
		[Embed(source="../media/graphics/money/moneydrugs_PH_020.png")]
		public static const money19:Class;
		[Embed(source="../media/graphics/money/moneydrugs_PH_021.png")]
		public static const money20:Class;
		[Embed(source="../media/graphics/money/moneydrugs_PH_022.png")]
		public static const money21:Class;
		[Embed(source="../media/graphics/money/moneydrugs_PH_023.png")]
		public static const money22:Class;
		[Embed(source="../media/graphics/money/moneydrugs_PH_024.png")]
		public static const money23:Class;
		
	}
}
