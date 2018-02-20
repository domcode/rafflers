import sys.io.File;

class Raffler {
    static public function main():Void {
        var content = File.getContent(Sys.args()[0]);

        var names = StringTools.trim(content).split("\n");

        Sys.println(names[Std.random(names.length)]);
    }
}

