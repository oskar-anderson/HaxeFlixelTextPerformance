package;

import openfl.display.FPS;
import flixel.FlxGame;
import openfl.display.Sprite;

class Main extends Sprite
{
	public function new()
	{
		super();
		addChild(new FlxGame(0, 0, PlayState));
		var fps = new FPS(0, 0, 0xff0000);
		fps.scaleX = 4;
		fps.scaleY = 4;
		addChild(fps);
	}
}
