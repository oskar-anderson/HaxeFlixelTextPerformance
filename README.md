# HaxeFlixelTextPerformance

## Results
Platvorm; Kaadrite sagedus sekundites (FPS)  
Windows 10 Google Chrome; 63  
Windows 10 Mozilla Firefox; 33  
Windows 10 lauaarvuti (C++); 96  
Linux Mint 20 lauaarvuti; 103  
Windows 10 NekoVM; 5  
Windows 10 Hashlink; 22  


## Getting started
1. Install [Haxe](https://haxe.org/download/)
2. Install dependencies:
```
haxelib install lime
haxelib install openfl
haxelib install flixel
haxelib run lime setup flixel
haxelib run lime setup
```
3. Choose a platform to target:
```
lime test your_platform_option_here
valid_platform_options = [html5, linux, windows, neko, hl]
```
