package
{
	import net.flashpunk.Engine;
	import net.flashpunk.FP;
	import worlds.GameWorld;
	
	/**
	 * ...
	 * @author James Keats
	 */
	public class Main extends Engine 
	{
		[SWF(width = "640", height = "360")]
		
		public static const FPS:int = 60;
		
		public function Main() 
		{
			super(640, 360, FPS, false);
			
			FP.world = new GameWorld();
			FP.console.enable();
		}
		
	}
	
}