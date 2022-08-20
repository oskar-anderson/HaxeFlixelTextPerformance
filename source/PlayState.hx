package;

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
import flixel.tweens.FlxTween;
import flixel.util.FlxColor;

class PlayState extends FlxState
{
	var beginning:Date = null;
	var text:FlxText;
	var spaceship:FlxSprite;
	var frameCountText:FlxText;
	var frameCount: Int = 0;
	var bitmapFont: FlxBitmapFont;
	var board: Array<Array<FlxBitmapText>> = null;
	var useTextAsCells = true; // false for text as row
	var isTextChanging = false;
	var exitTimeDuration = 10000;

	override public function create():Void
	{
		super.create();
		// FlxG.fixedTimestep = true;
		// FlxG.updateFramerate = 1; // WTF does this even do?
		// FlxG.drawFramerate = 30;

		// var save = new FlxSave();
		// save.bind("myitem");
		// save.data.name = "Hello";
		// FlxG.save.data.name = "Hello";
		// FlxG.save.flush();
		// save.flush();

		if (false) {
			spaceship = new FlxSprite();
			spaceship.loadGraphic(AssetPaths.spaceship__png);
			spaceship.x = 100;
			spaceship.y = 0;
			add(spaceship);
		}
		/*
			FlxTween.tween(spaceship, {
				x: FlxG.width - spaceship.width,
				y: FlxG.height - spaceship.height,
				angle: 90.0
			}, 5, {type: FlxTweenType.PINGPONG});
		 */

		frameCountText = new FlxText(0, 0, FlxG.width, "0", 64);
		frameCountText.setFormat(null, 64, FlxColor.RED, FlxTextAlign.CENTER);
		
		bitmapFont = FlxBitmapFont.fromAngelCode("assets/images/ps2p-bmfont-xml-14/ps2p-14_0.png", "assets/images/ps2p-bmfont-xml-14/ps2p-14.fnt");
		
		
		board = GenerateRandomBoardFlxBitmapText(bitmapFont);
		var newboard = GenerateRandomBoardStr();

		for (y in 0...100)
		{
			var s = "";
			for (x in 0...400)
			{
				if (useTextAsCells) {
					add(board[y][x]);
				}
				else {
					s += newboard[y][x];
				}
			}
			if (! useTextAsCells) {
				board[y][0].text = s;
				add(board[y][0]);
			}
		}
		beginning = Date.now();

		add(frameCountText);
	}

	override public function update(elapsed:Float):Void
	{
		// trace("update start, framecount: " + frameCount);
		super.update(elapsed);


		frameCount++;
		// trace((Date.now().getTime() - beginning.getTime()) / 1000);
		if ((Date.now().getTime() - beginning.getTime()) / 1000 > exitTimeDuration) {
			trace('Game exited with framecount: ' + frameCount);
			flash.system.System.exit(0);
			trace("flash.system.System.exit(0);");
			System.exit(0);
		}

		frameCountText.y = FlxG.height - 64;
		frameCountText.text = Std.string(frameCount);
		if (false) {
			spaceship.x += 10 * elapsed;

			if (FlxG.keys.pressed.LEFT)
				spaceship.x--;
			if (FlxG.keys.pressed.RIGHT)
				spaceship.x++;
			if (FlxG.keys.justReleased.UP)
			{
				spaceship.y = spaceship.y - 100;
			}
			if (FlxG.keys.justReleased.DOWN)
			{
				spaceship.y = spaceship.y + 100;
			}

			if (FlxG.keys.anyJustPressed([FlxKey.ESCAPE, FlxKey.SPACE]))
			{
				spaceship.x = FlxG.width / 2 - spaceship.width / 2;
				spaceship.y = FlxG.height / 2 - spaceship.height / 2;
			}
		}

		if (FlxG.keys.justPressed.P)
		{
			
			#if sys
			trace("file system can be accessed!");
			#end
		}

		
		if (isTextChanging) {

			var newboard = GenerateRandomBoardStr();
			for (y in 0...100)
			{
				var s = new StringBuf();
				for (x in 0...400)
				{
					if(useTextAsCells) {
						board[y][x].text = newboard[y][x];
					}
					else {
						s.add(newboard[y][x]);
					}
				}
				if (!useTextAsCells) {
					board[y][0].text = s.toString();
				}
			}
		}

		// trace("update end" + frameCount);
		
	}

	public static function GenerateRandomBoardStr():Array<Array<String>> {
		var board:Array<Array<String>> = [for (y in 0...240) [for (x in 0...400) null]];
		var randomPool = "ABCDEFGHIJKLMNOPQRSTUVWabcdefghijklmnopqrstuvw";
		var random = new FlxRandom();
		for (y in 0...100) {
			for (x in 0...400) {
				var letter = randomPool.charAt(random.int(0, randomPool.length));
				board[y][x] = letter;
			}
		}
		return board;
	}

	public static function GenerateRandomBoardFlxText():Array<Array<FlxText>>
	{
		var board:Array<Array<FlxText>> = [for (y in 0...240) [for (x in 0...320) null]];
		var randomPool = "ABCDEFGHIJKLMNOPQRSTUVWabcdefghijklmnopqrstuvw";
		var random = new FlxRandom();
		for (y in 0...100)
		{
			for (x in 0...100)
			{
				var letter = randomPool.charAt(random.int(0, randomPool.length));
				var flxText = new FlxText(x * 14, y * 14, 0, letter, 14);
				board[y][x] = flxText;
			}
		}
		return board;
	}

	public static function GenerateRandomBoardFlxBitmapText(bitmapFont):Array<Array<FlxBitmapText>>
	{
		var board:Array<Array<FlxBitmapText>> = [for (y in 0...240) [for (x in 0...400) null]];
		var randomPool = "ABCDEFGHIJKLMNOPQRSTUVWabcdefghijklmnopqrstuvw";
		var random = new FlxRandom();
		for (y in 0...100)
		{
			for (x in 0...400)
			{
				var letter = randomPool.charAt(random.int(0, randomPool.length));
				var flxText = new FlxBitmapText(bitmapFont);
				flxText.text = letter;
				flxText.y = y * 14;
				flxText.x = x * 14;
				board[y][x] = flxText;
			}
		}
		return board;
	}
}
