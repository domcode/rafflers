import scala.util.Random
import scala.io.Source

object Raffler {
    def main(args: Array[String]) {
        try {
          val contestants = Random.shuffle(Source.fromFile(args(0)).getLines()).toList
          chooseWinner(contestants)
        } catch {
          case _: Throwable => println("Could not load the file.")
        }
    }

    def chooseWinner(contestants: List[String]): Unit = {
        if ( ! contestants.isEmpty) {
          println(contestants.head)
        }
    }
}
