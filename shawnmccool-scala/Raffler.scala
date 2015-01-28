
object Raffler {
  def main(args: Array[String]) {
    import scala.util.Random
    import scala.io.Source

    def raffleUntil(contestants: List[String], done: () => Boolean) = {
      def chooseWinner(contestants: List[String]): Unit = {
        if ( ! contestants.isEmpty) {
          println(contestants.head)
          if ( ! done()) chooseWinner(contestants.tail)
        }
      }
      chooseWinner(contestants)
    }

    println("Press enter to select a winner, q on a blank line to quit.");
    Console.in.read

    try {
      val contestants = Random.shuffle(Source.fromFile(args(0)).getLines()).toList
      raffleUntil(contestants, () => Console.in.read == 'q')
    } catch {
      case _: Throwable => println("Could not load the file.")
    }

  }
}

