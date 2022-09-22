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
	var exitTimeDuration = 10000;
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

		// var save = new FlxSave();
		// save.bind("myitem");
		// save.data.name = "Hello";
		// FlxG.save.data.name = "Hello";
		// FlxG.save.flush();
		// save.flush();

		frameCountText = new FlxText(0, 0, FlxG.width, "0", 64);
		frameCountText.setFormat(null, 64, FlxColor.RED, FlxTextAlign.CENTER);
		
		bitmapFont = FlxBitmapFont.fromAngelCode("assets/images/ps2p-bmfont-xml-14/ps2p-14_0.png", "assets/images/ps2p-bmfont-xml-14/ps2p-14.fnt");
		
		
		board = GenerateRandomBoardFlxBitmapText(bitmapFont);
		var newboard = GenerateRandomBoardStr();

		for (y in 0...height)
		{
			var s = "";
			for (x in 0...width)
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
		deltaTimes.push(elapsed);
		if (deltaTimes.length > 100) {
			deltaTimes.shift();
		}

		frameCount++;
		// trace((Date.now().getTime() - beginning.getTime()) / 1000);
		if ((Date.now().getTime() - beginning.getTime()) / 1000 > exitTimeDuration) {
			trace('Game exited with framecount: ' + frameCount);
			flash.system.System.exit(0);
			trace("flash.system.System.exit(0);");
			System.exit(0);
		}

		if (FlxG.keys.justPressed.Q) {
			var script = "
				var sample = 'My name is <strong>::name::</strong>, <em>::age::</em> years old';
				var user = {name: 'Mark', age: 30};
				var template = new haxe.Template(sample);
				var output = template.execute(user);
				trace(File.absolutePath());
				trace(output);

				function main() {
					// var err = 0;;
					// var angles = [60,60];  // cos(60) is 0.5
					sum = 0;
					for( a in angles )
						sum += Math.cos(a);
					return sum;
				}

				function main2() {
					return 'asd';
				}

				main();
			";
			var parser = new hscript.Parser();
			var program = parser.parseString(script);
			var interp = new hscript.Interp();
			interp.variables.set("Math", Math); // share the Math class
			interp.variables.set("angles", [0,1,2,3]); // set the angles list
			try {
				trace(interp.execute(program) );
			} catch(e:Any) {

			}
				

			var sample = 'Compiled version. My name is <strong>::name::</strong>, <em>::age::</em> years old';
			var user = {name: 'Mark', age: 30};
			var template = new haxe.Template(sample);
			var output = template.execute(user);
			trace(output);
		}


		frameCountText.y = FlxG.height - 64;
		frameCountText.text = Std.string(frameCount);

		if (FlxG.keys.justPressed.P)
		{
			
			#if sys
			trace("file system can be accessed!");
			#end
		}

		
		if (FlxG.keys.pressed.Q) {

			var newboard = GenerateRandomBoardStr();
			for (y in 0...height)
			{
				var s = new StringBuf();
				for (x in 0...width)
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
		for (y in 0...height) {
			for (x in 0...width) {
				var letter = randomPool.charAt(random.int(0, randomPool.length - 1));
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
		for (y in 0...height)
		{
			for (x in 0...width)
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
		for (y in 0...height)
		{
			for (x in 0...width)
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

	/**
    	Uses Math.round to fix a floating point number to a set precision.
	**/
	public static function round(number:Float, ?precision=2): Float
	{
		number *= Math.pow(10, precision);
		return Math.round(number) / Math.pow(10, precision);
	}
}
