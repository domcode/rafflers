use "files"
use "random"
use "collections/persistent"
use "itertools"
use "time"

actor Main
  new create(env: Env) =>
    // setup rights (capabilites) for file, used later
    let caps = recover val FileCaps.>set(FileRead).>set(FileStat) end

    // Checking if argument supplied (first is program self/this filename)
    if env.args.size() != 2 then
      env.out.print("No file supplied")
    end

    try
      // check if file exists is writable etc
      with namesFile = OpenFile(
        FilePath(env.root as AmbientAuth, env.args(1)?, caps)?) as File
      do
        // read in file, removing blank lines
        let names: List[String] = Lists[String].from(namesFile.lines()).filter({(s: String): Bool => s != "" })
        let count = names.size().u64()

        let random = MT(Time.millis())
        let winnerIndex = USize.from[U64](random.next() % count)

        // names is a List (not Array), hence no index based access
        env.out.print(names.drop(winnerIndex).head()?.string())
      end
    else
      try
        env.out.print("Couldn't open " + env.args(1)?)
      end
    end
