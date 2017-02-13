import std.file;
import std.random;
import std.stdio;
import std.string;
import core.stdc.stdlib;

void main(string[] args)
{
    if (args.length < 2 || args[1] == "help") {
        writeln("[ERROR] No file path found.");
        writeln("   Usage: raffler <FILE_PATH>");
        exit(1);
    }

    try {
        args[1].readText.strip.splitLines.choice.writeln;
    } catch (FileException e) {
        writeln("[ERROR] Could not read file. ", e.msg);
        exit(1);
    }
}
