package entities.ui 
{
	import net.flashpunk.Entity;
	import net.flashpunk.FP;
	import net.flashpunk.Graphic;
	import net.flashpunk.graphics.Graphiclist;
	import net.flashpunk.graphics.Image;
	import net.flashpunk.Mask;
	import net.flashpunk.utils.Input;
	
	/**
	 * ...
	 * @author James Keats
	 */
	public class OptionsMenu extends Entity 
	{
		private var mType:String;
		private var volumeBar:Image;
		
		public function OptionsMenu(type:String = "howto", x:Number=0, y:Number=0, graphic:Graphic=null, mask:Mask=null) 
		{
			if (type == "volume") mType = "volume";
			else mType = "howto";
			
			var bgImg:Image = new Image(C.CONTROLS_MENU_BASE);
			
			var insert:Image;
			if (type == "volume")
			{
				insert = new Image(C.CONTROLS_INSERT_VOLUMECONTROL);
				volumeBar = new Image(C.CONTROLS_INSERT_VOLUMECONTROL_BAR);
				volumeBar.x = 325; volumeBar.y = 80;
				volumeBar.scaleX = Main.VOLUME;
				graphic = new Graphiclist(bgImg, volumeBar, insert);
			}
			else
			{
				insert = new Image(C.CONTROLS_INSERT_HOWTOPLAY);
				graphic = new Graphiclist(bgImg, insert);
			}
				
			insert.x = 75; insert.y = 30;
			
			graphic.scrollX = 0;
			graphic.scrollY = 0; //ui element; fix position on the screen
			super(x, y, graphic, mask);
		}
		
		override public function update():void
		{
			super.update();
			
			if (this.world && this.mType == "volume" && Input.mousePressed)
			{
				checkVolumeUp();
				checkVolumeDown();
			}
		}
		
		private function checkVolumeUp():void 
		{
			//hardcoded volume positions because they're just a part of the image.
			var clicked:Boolean = checkPosClicked(530, 67.5, 560, 97.5);
			
			if (clicked)
			{
				Main.VOLUME = FP.clamp(Main.VOLUME + 0.1, 0.3, 1);
				this.volumeBar.scaleX = Main.VOLUME;
			}
		}
		
		private function checkVolumeDown():void 
		{
			//hardcoded volume positions because they're just a part of the image.
			var clicked:Boolean = checkPosClicked(290, 67.5, 320, 97.5);
			
			if (clicked)
			{
				Main.VOLUME = FP.clamp(Main.VOLUME - 0.1, 0.3, 1);
				this.volumeBar.scaleX = Main.VOLUME;
			}
		}
		
		private function checkPosClicked(left:Number, top:Number, right:Number, bottom:Number):Boolean
		{
			if (Input.mouseX > left && Input.mouseY > top && Input.mouseX < right && Input.mouseY < bottom)
				return true;
			else
				return false;
		}
		
	}

}