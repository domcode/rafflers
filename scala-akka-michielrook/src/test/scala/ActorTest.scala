import akka.actor.{Actor, ActorSystem}
import akka.testkit.{ImplicitSender, TestActorRef, TestKit}
import org.scalatest.{BeforeAndAfterAll, FlatSpecLike, MustMatchers}

import scala.reflect.ClassTag

abstract class ActorTest[T <: Actor: ClassTag] extends TestKit(ActorSystem()) with FlatSpecLike with ImplicitSender with MustMatchers with BeforeAndAfterAll {
  trait ActorTestSetup {
    val actor = TestActorRef[T]
  }

  override def afterAll {
    TestKit.shutdownActorSystem(system)
  }
}
