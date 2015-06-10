package Worlds 
{
	import Entities.MovingPlatform;
	import Entities.SoundThingTest;
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
		
		public function TestWorld() 
		{
			super();
			
			platform= new MovingPlatform(4, 400, 300);
			add(platform);
			
			add(new SoundThingTest());
		}
		
		override public function update():void
		{
			super.update();
			
			if (Input.pressed(Key.SPACE))
				platform.moveUp();
		}
		
	}

}