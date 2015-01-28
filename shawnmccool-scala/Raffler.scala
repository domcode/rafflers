
object Raffler {
  def main(args: Array[String]) {
    import scala.util.Random
    import scala.io.Source

    def raffleUntil(contestants: List[String], done: () => Boolean) = {
      println("Press enter to select a winner, q on a blank line to quit.");
      Console.in.read

      def chooseWinner(contestants: List[String]): Unit = {
        if ( ! contestants.isEmpty) {
          println(contestants.head)
          if ( ! done()) chooseWinner(contestants.tail)
        }
      }

      chooseWinner(contestants)
    }

    val qEntered = () => Console.in.read == 113;

    try {
      val contestants = Random.shuffle(Source.fromFile(args(0)).getLines()).toList
      raffleUntil(contestants, qEntered)
    } catch {
      case _: Throwable => println("Could not load the file.")
    }

  }
}

