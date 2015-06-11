package worlds 
{
	import entities.MovingPlatform;
	import entities.SoundThingTest;
	import net.flashpunk.utils.Input;
	import net.flashpunk.utils.Key;
	import net.flashpunk.World;
	
	/**
	 * ...
	 * @author James Keats
	 */
	public class TestWorld extends World 
	{
		private var platform:MovingPlatform;
		private var platform2:MovingPlatform;
		
		private var soundTest:SoundThingTest;
		
		public function TestWorld()
		{
			super();
			
			platform= new MovingPlatform(4, 400, 300);
			add(platform);
			
			platform2 = new MovingPlatform(4, 400 - 128, 300);
			add(platform2);
			
			soundTest = new SoundThingTest(updatePlatform);
			add(soundTest);
		}
		
		override public function update():void
		{
			super.update();
			
			if (Input.pressed(Key.SPACE))
				platform.moveUp();
		}
		
		private function updatePlatform(platformIDtoUpdate:int):void
		{
			if (platformIDtoUpdate == 0)
				platform.moveUp();
			else
				platform2.moveUp();
		}
		
	}

}