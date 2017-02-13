import std.file;
import std.random;
import std.stdio;
import std.string;
import core.stdc.stdlib;

void main(string[] args)
{
    try {
        args[1].readText.strip.splitLines.choice.writeln;
    } catch (FileException e) {
        writeln("[ERROR] Could not read file. ", e.msg);
        exit(1);
    }
}
