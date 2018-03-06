import RafflingActor._
import akka.actor.{Actor, ActorLogging, ActorRef, ActorSystem, Props, Terminated}
import com.google.inject.Guice
import com.google.inject.name.Names
import net.codingwell.scalaguice.InjectorExtensions._

object Raffler extends App {
  args.headOption.fold {
    println("Please specify a file containing a newline-separated list of names")

    System.exit(1)
  } { file =>
    val injector = Guice.createInjector(new RafflerModule)

    val actorSystem = injector.instance[ActorSystem]

    val rafflingActor = injector.instance[ActorRef](Names.named(RafflingActor.Name))

    val terminator = actorSystem.actorOf(Props(classOf[Terminator], rafflingActor), "app-terminator")

    rafflingActor ! Raffle(file)
  }

  class Terminator(app: ActorRef) extends Actor with ActorLogging {
    context watch app
    def receive = {
      case Terminated(_) =>
        log.info("Terminating")
        context.system.terminate()
    }
  }
}
