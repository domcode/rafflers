import akka.actor._
import com.google.inject._
import com.google.inject.name.Names
import net.codingwell.scalaguice.InjectorExtensions._
import net.codingwell.scalaguice.ScalaModule

import scala.reflect.ClassTag

class RafflerModule extends AbstractModule with ScalaModule {
  override def configure() {
    bind[ActorSystem].toInstance(ActorSystem("Raffler"))

    bindActor[RaffleContainerActor](RaffleContainerActor.Name)
    bindActor[RafflingActor](RafflingActor.Name)
  }

  private def bindActor[T <: Actor: ClassTag](name: String)(implicit m: Manifest[T]) = {
    bind[ActorRef]
      .annotatedWith(Names.named(name))
      .toProvider(new Provider[ActorRef] {
        @Inject private var injector: Injector = _
        lazy val get = {
          injector.instance[ActorSystem].actorOf(Props(injector.instance[T]), name)
        }
      })
      .asEagerSingleton()
  }
}
