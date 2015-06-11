package entities 
{
	import entities.music.MusicTag;
	import flash.media.Sound;
	import flash.utils.ByteArray;
	import net.flashpunk.Entity;
	import net.flashpunk.Graphic;
	import net.flashpunk.Mask;
	import net.flashpunk.Sfx;
	
	/**
	 * ...
	 * @author James Keats
	 */
	public class SoundThingTest extends Entity 
	{
		private var myTag:MusicTag;
		private var myTagTwo:MusicTag;
		private var setPlatformFunction:Function;
		
		public function SoundThingTest(updatePlatformFunction:Function, x:Number=0, y:Number=0, graphic:Graphic=null, mask:Mask=null) 
		{
			super(x, y, graphic, mask);
			this.setPlatformFunction = updatePlatformFunction;
		}
		
		override public function added():void
		{
			myTag = new MusicTag(800, 1.2, new <int>[0]);
			myTag.resetMyBar = setPlatformFunction;
			
			myTagTwo = new MusicTag(800, 1.0, new <int>[1], 400);
			myTagTwo.resetMyBar = setPlatformFunction;
			
			var song:Sfx = new Sfx(C.SONG_2);
			song.play();
			song.complete = reset;
			
			myTag.startTimer();
			myTagTwo.startTimer();
		}
		
		private function reset():void 
		{
			myTag.stopTimer();
			myTagTwo.stopTimer();
			
			myTag = null;
			myTagTwo = null;
			
			added();
		}
	}

}