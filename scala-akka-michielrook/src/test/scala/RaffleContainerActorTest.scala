import RaffleContainerActor._
import shared.Rafflers.Name

class RaffleContainerActorTest extends ActorTest[RaffleContainerActor] {
  "raffle container actor" should "register a name" in new ActorTestSetup {
    actor ! RegisterName(Name)

    actor.underlyingActor.names must contain(Name)
  }

  "raffle container actor" should "raffle a name" in new ActorTestSetup {
    actor ! RegisterName(Name)

    actor ! DrawName

    expectMsg(NameDrawn(Name))
  }

  "raffle container actor" should "not raffle a name if no names were registered" in new ActorTestSetup {
    actor ! DrawName

    expectMsg(ContainerEmpty)
  }
}
