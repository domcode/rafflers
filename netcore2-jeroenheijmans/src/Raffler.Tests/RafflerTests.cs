namespace Raffler.Tests
{
    using System;
    using Microsoft.VisualStudio.TestTools.UnitTesting;

    [TestClass]
    public class RafflerTests
    {
        [TestMethod]
        public void Can_select_single_winner_from_solo_list()
        {
            var randomizer = new FakeRandomizer().AlwaysReturningItemAtIndex(0);
            var raffler = new Raffler(randomizer, new Candidate[] { "John Doe" });
            var result = raffler.Raffle();
            Assert.AreEqual("John Doe", result.Name);
        }

        [TestMethod]
        public void Can_select_single_winner_multi_list()
        {
            var randomizer = new FakeRandomizer().AlwaysReturningItemAtIndex(1);
            var raffler = new Raffler(randomizer, new Candidate[] { "John", "Marc", "Maria" });
            var result = raffler.Raffle();
            Assert.AreEqual("Marc", result.Name);
        }

        [TestMethod]
        public void Wont_select_same_winner_twice()
        {
            var randomizer = new FakeRandomizer().AlwaysReturningItemAtIndex(0);
            var raffler = new Raffler(randomizer, new Candidate[] { "John", "Marc", "Maria" });
            Assert.AreEqual("John", raffler.Raffle().Name);
            Assert.AreEqual("Marc", raffler.Raffle().Name);
            Assert.AreEqual("Maria", raffler.Raffle().Name);
        }

        [TestMethod]
        public void Throws_when_no_candidates_left()
        {
            var randomizer = new FakeRandomizer().AlwaysReturningItemAtIndex(0);
            var raffler = new Raffler(randomizer, new Candidate[] { "John" });
            Assert.AreEqual("John", raffler.Raffle().Name);
            Assert.ThrowsException<NoMoreCandidatesException>(() => raffler.Raffle());
        }
    }
}
