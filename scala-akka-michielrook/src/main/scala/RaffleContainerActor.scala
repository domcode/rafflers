import RaffleContainerActor._
import akka.actor.Actor

import scala.collection.mutable.ListBuffer
import scala.util.Random

object RaffleContainerActor {
  case class RegisterName(name: String)
  case object DrawName
  case class NameDrawn(name: String)
  case object ContainerEmpty

  final val Name = "raffle-container-actor"
}

class RaffleContainerActor extends Actor {
  val names: ListBuffer[String] = new ListBuffer

  def receive = {
    case RegisterName(name) => names += name
    case DrawName =>
      val name = Random.shuffle(names).headOption.fold {
        sender ! ContainerEmpty
      } { name =>
        sender ! NameDrawn(name)
      }
  }
}
