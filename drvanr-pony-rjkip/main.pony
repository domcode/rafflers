use "files"
use "random"
use "collections/persistent"
use "itertools"
use "time"

actor Main
  new create(env: Env) =>
    try
      let auth = env.root as AmbientAuth

      let path: FilePath = FilePath(auth, "/var/names.txt")
      let namesFile: File = File.open(path)

      let names: List[String] = Lists[String].from(Filter[String](namesFile.lines(), lambda(s: String): Bool => s != "" end))
      let count = names.size().u64()

      let random = MT(Time.millis())
      let winnerIndex = USize.from[U64](random.next() % count)

      env.out.print(names.drop(winnerIndex).head().string())
    end
