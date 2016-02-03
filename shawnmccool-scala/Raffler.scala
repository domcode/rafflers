import scala.util.Random
import scala.io.Source

def chooseWinner(contestants: List[String]): Unit = {
    if ( ! contestants.isEmpty) {
      println(contestants.head)
    }
}

try {
  val contestants = Random.shuffle(Source.fromFile(args(0)).getLines()).toList
  chooseWinner(contestants)
} catch {
  case _: Throwable => println("Could not load the file.")
}
