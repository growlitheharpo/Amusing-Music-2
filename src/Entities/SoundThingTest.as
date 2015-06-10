package Entities 
{
	import Entities.Music.MusicTag;
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
		
		public function SoundThingTest(x:Number=0, y:Number=0, graphic:Graphic=null, mask:Mask=null) 
		{
			super(x, y, graphic, mask);
			
		}
		
		override public function added():void
		{
			myTag = new MusicTag(800, 1.2, new <int>[0]);
			myTag.resetMyBar = checkTest;
			
			var song:Sfx = new Sfx(C.SONG_1);
			song.loop();
			myTag.startTimer();
		}
		
		private function checkTest(testvar:int):void
		{
			trace("Hit!");
		}
	}

}