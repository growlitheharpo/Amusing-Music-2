/* *****************************************************************************
 * Amusing Music 2 is a portfolio piece demonstrating rhythm-based platforming.
 *   Copyright (C) 2015  James Keats (www.jameskeats.com)
 *
 *  This program is free software: you can redistribute it and/or modify
 *  it under the terms of the GNU General Public License as published by
 *  the Free Software Foundation, either version 3 of the License, or
 *  any later version.
 ****************************************************************************** */
package entities.sound.music 
{
	import entities.sound.MusicTag;
	/**
	 * ...
	 * @author James Keats
	 */
	public class Song5Sfx extends MySfx 
	{
		
		public function Song5Sfx(myPlatformIDs:Vector.<Vector.<int>>, complete:Function=null, type:String=null) 
		{
			super(C.SONG_5, complete, type);
			
			var platform1:MusicTag = new MusicTag(800, 1.2, myPlatformIDs[0]);
			var platform2:MusicTag = new MusicTag(800, 1.0, myPlatformIDs[1], 400);
			var platform3:MusicTag = new MusicTag(650, 0.4, myPlatformIDs[2]);
			var platform4:MusicTag = new MusicTag(350, 0.8, myPlatformIDs[3]);
			
			this.myMusicTagList.push(platform1, platform2, platform3, platform4);
		}
		
	}

}