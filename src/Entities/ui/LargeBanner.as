package entities.ui 
{
	import net.flashpunk.Entity;
	import net.flashpunk.Graphic;
	import net.flashpunk.graphics.Text;
	import net.flashpunk.Mask;
	
	/**
	 * ...
	 * @author James Keats
	 */
	public class LargeBanner extends Entity 
	{
		
		public function LargeBanner(bannerText:String, x:Number=0, y:Number=0, graphic:Graphic=null, mask:Mask=null) 
		{
			//font size = 72, color = 0066cc
			var nText:Text = new Text(bannerText, 0, 0, { font:"Broadway", color:0x0066CC, size:72, align:"center" } );
			nText.x = -(nText.width / 2);
			
			graphic = nText;
			
			super(x, y, graphic, mask);
		}
		
	}

}