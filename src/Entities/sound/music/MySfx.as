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
	import net.flashpunk.Sfx;
	
	/**
	 * ...
	 * @author James Keats
	 */
	public class MySfx extends Sfx 
	{
		protected var myMusicTagList:Vector.<MusicTag>
		protected var hasFunctionBeenSet:Boolean = false;
		
		public var setPlatformFunction:Function;
		
		/**
		 * This class should be considered a VIRTUAL CLASS. It should NOT be instantiated.
		 * @param platformID The ID of the platform to move.
		 */
		public function MySfx(source:*, complete:Function=null, type:String=null) 
		{
			super(source, complete, type);
			myMusicTagList = new Vector.<MusicTag>();
		}
		
		/**
		 * Start running the music tags. Only called after the list has been set up.
		 */
		public function turnOnMusicTags():void
		{
			if (!hasFunctionBeenSet)
			{
				for (var i:int = 0; i < myMusicTagList.length; i++) 
				{
					myMusicTagList[i].resetMyBar = setPlatformFunction;
				}
				
				hasFunctionBeenSet = true;
			}
			
			for (i = 0; i < myMusicTagList.length; i++)
			{
				myMusicTagList[i].startTimer();
			}
		}
		
		/**
		 * Halt music tags. Currently (purposefully) unsafe: causes error if
		 * called more than once.
		 */
		public function turnOffMusicTags():void
		{
			for (var i:int = 0; i < myMusicTagList.length; i++) 
			{
				myMusicTagList[i].stopTimer();
				myMusicTagList[i] = null;
			}
		}
	}

}