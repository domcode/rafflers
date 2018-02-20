import java.io.File
import java.io.IOException
import java.util.Random

object Raffler {
    @Throws(IOException::class)
    @JvmStatic fun main(args: Array<String>) {
        val inputFile = File(args[0])
        val attendeeList = inputFile.readLines()
        val winnerInt = Random().nextInt(attendeeList.size)
        println (attendeeList[winnerInt])
    }
}
