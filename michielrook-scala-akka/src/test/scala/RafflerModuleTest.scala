import akka.actor.ActorRef
import com.google.inject.Guice
import com.google.inject.name.Names
import org.scalatest.{FlatSpec, MustMatchers}
import net.codingwell.scalaguice.InjectorExtensions._

class RafflerModuleTest extends FlatSpec with MustMatchers {
  "raffler module" should "initialize injector" in {
    val injector = Guice.createInjector(new RafflerModule)

    injector.instance[ActorRef](Names.named(RaffleContainerActor.Name)) must be(an[ActorRef])
    injector.instance[ActorRef](Names.named(RafflingActor.Name)) must be(an[ActorRef])
  }
}
