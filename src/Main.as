package
{
	import net.flashpunk.Engine;
	import net.flashpunk.FP;
	import Worlds.TestWorld;
	
	/**
	 * ...
	 * @author James Keats
	 */
	public class Main extends Engine 
	{
		[SWF(width = "800", height = "400")]
		
		public function Main() 
		{
			super(800, 400, 60, false);
			
			FP.world = new TestWorld();
		}
		
	}
	
}