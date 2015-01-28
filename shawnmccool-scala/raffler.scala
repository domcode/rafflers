
object Raffler {
  def main(args: Array[String]) {
    if (args.length == 0) throw new IllegalArgumentException("You must specify a names file.");

    import scala.util.Random
    import scala.io.Source

    def showNames(names: List[String]) = {
      println("Press enter to start, q on a blank line to quit.");
      Console.in.read

      def readNames(names: List[String]): Unit = {
        if ( ! names.isEmpty) {
          println(names.head)
          if (Console.in.read != 113) readNames(names.tail)
        }
      }

      readNames(names)
    }

    try {
      val names = Random.shuffle(Source.fromFile(args(0)).getLines()).toList
      showNames(names)
    } catch {
      case _: Throwable => println("Could not load the file.")
    }

  }
}

