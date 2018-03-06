namespace Raffler.Tests
{
    using Microsoft.VisualStudio.TestTools.UnitTesting;

    [TestClass]
    public class CandidateTests
    {
        [TestMethod]
        public void Construction_via_string_cast_operator_sets_name()
        {
            var candidate = (Candidate)"John";
            Assert.AreEqual("John", candidate.Name);
        }

        [TestMethod]
        public void ToString_contains_name()
        {
            var candidate = new Candidate("John");
            Assert.IsTrue(candidate.ToString().ToLowerInvariant().Contains("john"));
        }
    }
}
