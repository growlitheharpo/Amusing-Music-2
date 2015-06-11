package worlds 
{
	import entities.MovingPlatform;
	import entities.sound.SoundManager;
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
		
		private var soundManager:SoundManager;
		
		public function TestWorld()
		{
			super();
			
			platform= new MovingPlatform(4, 400, 300);
			add(platform);
			
			platform2 = new MovingPlatform(4, 400 - 128, 300);
			add(platform2);
			
			soundManager = new SoundManager(0);
			soundManager.setPlatformFunction = updatePlatform;
			soundManager.init();
		}
		
		override public function update():void
		{
			super.update();
			
			if (Input.pressed(Key.S))
				soundManager.stop();
			else if (Input.pressed(Key.SPACE))
			{
				var vect1:Vector.<Vector.<int>> = new Vector.<Vector.<int>>();
				var vect2:Vector.<int> = new Vector.<int>();
				var vect3:Vector.<int> = new Vector.<int>();
				vect2.push(1);
				vect3.push(0);
				vect1.push(vect3, vect2);
				soundManager.setQueuedSound(1, vect1);
			}
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