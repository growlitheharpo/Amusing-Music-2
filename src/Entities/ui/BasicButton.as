package entities.ui 
{
	import net.flashpunk.Entity;
	import net.flashpunk.Graphic;
	import net.flashpunk.graphics.Graphiclist;
	import net.flashpunk.graphics.Image;
	import net.flashpunk.graphics.Text;
	import net.flashpunk.Mask;
	
	/**
	 * ...
	 * @author James Keats
	 */
	public class BasicButton extends Entity 
	{
		
		public function BasicButton(buttonLabel:String, fontSize:int = 30, x:Number=0, y:Number=0, graphic:Graphic=null, mask:Mask=null) 
		{
			var myImage:Image = new Image(C.BASIC_MENU_BUTTON);
			var nText:Text = new Text(buttonLabel, 0, 0, { font:"Broadway", color:0x000000, size:fontSize, align:"center" } );
			nText.x = (myImage.width / 2) - (nText.width / 2);
			nText.y = (myImage.height / 2) - (nText.height / 2);
			
			graphic = new Graphiclist(myImage, nText);
			
			setHitbox(myImage.width, myImage.height);
			
			super(x, y, graphic, mask);
		}
		
	}

}