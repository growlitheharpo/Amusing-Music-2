package worlds 
{
	import net.flashpunk.FP;
	import net.flashpunk.utils.Input;
	import net.flashpunk.utils.Key;
	import net.flashpunk.World;
	
	/**
	 * ...
	 * @author James Keats
	 */
	public class YouDiedMenu extends World 
	{
		private var levelToReturn:int;
		
		public function YouDiedMenu(levelToReturnTo:int) 
		{
			super();
			this.levelToReturn = levelToReturnTo;
			
			trace("You died! Press enter to return!");
		}
		
		override public function update():void
		{
			super.update();
			
			if (Input.pressed(Key.ENTER))
			{
				trace("respawn!");
				FP.world = new GameWorld(levelToReturn);
			}
		}
		
	}

}