package;

import openfl.display.FPS;
import haxe.Template;
import openfl.display.Bitmap;
import flixel.text.FlxBitmapText;
import openfl.Assets;
import flixel.graphics.frames.FlxBitmapFont;
import flixel.math.FlxRandom;
import flixel.math.FlxMath;
import flixel.util.FlxSave;
import openfl.display.LoaderInfo;
import lime.system.System;
import flixel.input.keyboard.FlxKey;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.text.FlxText;
import flixel.util.FlxColor;


class PlayState extends FlxState
{
	var frameCountText:FlxText;
	var frameCount: Int = 0;
	var bitmapFont: FlxBitmapFont;
	var board: Array<Array<FlxBitmapText>> = null;
	var deltaTimes = [];
	static var width = 100;
	static var height = 40;

	override public function create():Void
	{
		super.create();
		// FlxG.fixedTimestep = true;
		FlxG.updateFramerate = 600;
		FlxG.drawFramerate = 600;
		FlxG.mouse.useSystemCursor = true;

		frameCountText = new FlxText(0, 0, FlxG.width, "0", 64);
		frameCountText.setFormat(null, 64, FlxColor.RED, FlxTextAlign.CENTER);
		
		bitmapFont = FlxBitmapFont.fromAngelCode("assets/images/ps2p-bmfont-xml-8/ps2p-8-xml-32bit_0.png", "assets/images/ps2p-bmfont-xml-8/ps2p-8-xml-32bit.fnt");
		
		
		board = GenerateRandomBoardFlxBitmapText(bitmapFont);

		for (y in 0...height)
		{
			for (x in 0...width)
			{
				add(board[y][x]);
			}
		}
		add(frameCountText);
	}

	override public function update(elapsed:Float):Void
	{
		// trace("update start, framecount: " + frameCount);
		super.update(elapsed);
		deltaTimes.push(elapsed);
		if (deltaTimes.length > 100) {
			deltaTimes.shift();
		}

		frameCount++;
		frameCountText.y = FlxG.height - 64;
		frameCountText.text = Std.string(frameCount);

		if (FlxG.keys.pressed.Q) {

			var newboard = GenerateRandomBoardStr();
			for (y in 0...height)
			{
				for (x in 0...width)
				{
					board[y][x].text = newboard[y][x];
				}
			}
		}

		// trace("update end" + frameCount);
		
	}

	public static function GenerateRandomBoardStr():Array<Array<String>> {
		var board:Array<Array<String>> = [for (y in 0...240) [for (x in 0...400) null]];
		var randomPool = "ABCDEFGHIJKLMNOPQRSTUVWabcdefghijklmnopqrstuvw";
		var random = new FlxRandom();
		for (y in 0...height) {
			for (x in 0...width) {
				var letter = randomPool.charAt(random.int(0, randomPool.length - 1));
				board[y][x] = letter;
			}
		}
		return board;
	}

	public static function GenerateRandomBoardFlxBitmapText(bitmapFont):Array<Array<FlxBitmapText>>
	{
		var board:Array<Array<FlxBitmapText>> = [for (y in 0...240) [for (x in 0...400) null]];
		var randomPool = "ABCDEFGHIJKLMNOPQRSTUVWabcdefghijklmnopqrstuvw";
		var random = new FlxRandom();
		for (y in 0...height)
		{
			for (x in 0...width)
			{
				var letter = randomPool.charAt(random.int(0, randomPool.length));
				var flxText = new FlxBitmapText(bitmapFont);
				flxText.text = letter;
				flxText.y = y * 8;
				flxText.x = x * 8;
				board[y][x] = flxText;
			}
		}
		return board;
	}
}
