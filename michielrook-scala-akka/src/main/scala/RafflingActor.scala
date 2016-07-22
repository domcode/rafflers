import RaffleContainerActor.{ContainerEmpty, DrawName, NameDrawn, RegisterName}
import RafflingActor.Raffle
import akka.actor.{Actor, ActorLogging, ActorRef, PoisonPill}
import com.google.inject.Inject
import com.google.inject.name.Named

import scala.io.Source

object RafflingActor {
  case class Raffle(file: String)

  final val Name = "raffling-actor"
}

class RafflingActor @Inject()(@Named(RaffleContainerActor.Name) raffleContainerActor: ActorRef) extends Actor with ActorLogging {
  def receive = {
    case Raffle(file) =>
      try {
        log.info(s"Loading names from $file")
        Source.fromFile(file).getLines.foreach(raffleContainerActor ! RegisterName(_))
        raffleContainerActor ! DrawName
      } catch {
        case e: Exception =>
          log.error(e, "Unable to raffle")
          self ! PoisonPill
      }

    case NameDrawn(name) =>
      log.info(s"Raffled: $name")
      self ! PoisonPill

    case ContainerEmpty =>
      log.error("No names in raffle container")
      self ! PoisonPill
  }
}
