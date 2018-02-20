import java.io.{File, FileWriter, Writer}

import RaffleContainerActor.{ContainerEmpty, DrawName, NameDrawn, RegisterName}
import akka.actor.{ActorRef, PoisonPill}
import akka.testkit.TestActor.AutoPilot
import akka.testkit.{TestActor, TestActorRef, TestProbe}
import shared.Rafflers._

class RafflingActorTest extends ActorTest[RafflingActor] {
  trait RafflingActorTestSetup {
    val raffleContainerActor = new TestProbe(system)
    raffleContainerActor.setAutoPilot(new AutoPilot {
      var registeredName: Option[String] = None
      override def run(sender: ActorRef, msg: Any): AutoPilot = { msg match {
        case RegisterName(name) =>
          this.registeredName = Some(name)
          TestActor.KeepRunning
        case DrawName =>
          registeredName.fold(sender ! ContainerEmpty)(sender ! NameDrawn(_))
          TestActor.KeepRunning
        case _ => TestActor.KeepRunning
      }}
    })

    val actor = TestActorRef(new RafflingActor(raffleContainerActor.ref))

    val actorProbe = TestProbe()
    actorProbe watch actor
  }

  "raffling container" should "load names and raffle" in new RafflingActorTestSetup {
    actor ! RafflingActor.Raffle(generateRaffleFile(Seq(Name)))

    raffleContainerActor.expectMsg(RegisterName(Name))
    raffleContainerActor.expectMsg(DrawName)

    actorProbe.expectTerminated(actor)
  }

  "raffling container" should "not draw a name from empty file" in new RafflingActorTestSetup {
    actor ! RafflingActor.Raffle(generateRaffleFile(Seq()))

    raffleContainerActor.expectMsg(DrawName)

    actorProbe.expectTerminated(actor)
  }

  "raffling container" should "not load non-existent file" in new RafflingActorTestSetup {
    actor ! RafflingActor.Raffle("")

    raffleContainerActor.expectNoMsg()

    actorProbe.expectTerminated(actor)
  }

  private def generateRaffleFile(names: Seq[String]) = {
    val file = File.createTempFile("raffle", ".txt")

    val writer = new FileWriter(file)
    writer.write(names.mkString("\n"))
    writer.close()

    file.getAbsolutePath
  }
}
