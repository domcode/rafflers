namespace Raffler.Tests
{
    using System;
    using Microsoft.VisualStudio.TestTools.UnitTesting;

    [TestClass]
    public class InefficientRandomizerSmokeTests
    {
        [TestMethod]
        public void PickOne_wont_accept_null()
        {
            var sut = new InefficientRandomizer<object>();
            var exception = Assert.ThrowsException<ArgumentNullException>(
                () => sut.PickOne(null)
            );
            Assert.AreEqual("candidates", exception.ParamName);
        }

        [TestMethod]
        public void PickOne_wont_accept_empty_list()
        {
            var sut = new InefficientRandomizer<object>();
            var exception = Assert.ThrowsException<ArgumentException>(
                () => sut.PickOne(new object[0])
            );
            Assert.AreEqual("candidates", exception.ParamName);
        }

        [TestMethod]
        public void PickOne_can_pick_from_single_item_list()
        {
            var singleCandidate = new object();
            var sut = new InefficientRandomizer<object>();
            var result = sut.PickOne(new[] { singleCandidate });
            Assert.AreEqual(singleCandidate, result);
        }

        [TestMethod]
        public void PickOne_can_pick_from_multi_item_list()
        {
            var sut = new InefficientRandomizer<object>();
            var result = sut.PickOne(new[] { new object(), new object() });
            Assert.IsNotNull(result);
        }
    }
}