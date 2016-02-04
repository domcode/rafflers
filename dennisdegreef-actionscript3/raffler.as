#!/usr/bin/as3shebang

import shell.Program;
import Math;

function trim($string:String):String {
	if ($string == null) {
		return "";
	}
	return $string.replace(/^\s+|\s+$/g, "");
}

if (Program.argv.length == 0) {
    trace("usage: " + Program.filename + " names.txt");
} else {
    var namesString:String;
    var names:Array;
    var winner:String;

    namesString = FileSystem.nativeRead(Program.argv[0]);
    names = trim(namesString).split("\n");
    random = Math.floor(Math.random() * names.length);
    winner = names[random];

    trace("Winner winner, chicken dinner! The winner is: " + winner);

}
