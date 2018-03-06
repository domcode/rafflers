import os
import random

if os.paramCount() == 0:
    stderr.writeLine("No names file given.\n")
    stderr.writeLine("\n")
    stderr.writeLine("Usage: raffler <file>\n")
    quit(1)

let
    namesFile: string = os.paramStr(1)

var
    f: File
    names: seq[string] = @[]

try:
    if not f.open(namesFile, FileMode.fmRead):
        stderr.writeLine("Could not open names file")
        quit(1)
except IOError:
    let
        e = getCurrentException()
        msg = getCurrentExceptionMsg()
    stderr.writeLine("Got exception '" & repr(e) & "' with message '" & msg & "'")
    quit(1)

while not f.endOfFile():
    names.add(f.readLine())

stdout.writeLine(names[random.random(names.len)])
