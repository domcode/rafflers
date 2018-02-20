namespace Raffler.Tests
{
    using Microsoft.VisualStudio.TestTools.UnitTesting;

    [TestClass]
    public class StringExtensionsTests
    {
        [TestMethod]
        public void SplitInLines_returns_simple_single_line()
        {
            var result = StringExtensions.SplitInLines("some simple text");
            CollectionAssert.AreEqual(new[] { "some simple text" }, result);
        }

        [TestMethod]
        public void SplitInLines_returns_empty_array_for_empty_string()
        {
            var result = StringExtensions.SplitInLines("");
            CollectionAssert.AreEqual(new[] { "" }, result);
        }

        [TestMethod]
        public void SplitInLines_returns_null_for_null_input()
        {
            var result = StringExtensions.SplitInLines(null);
            Assert.IsNull(result);
        }

        [DataTestMethod]
        [DataRow("")]
        [DataRow(" ")]
        [DataRow("\t")]
        public void SplitInLines_returns_empty_string_for_simple_input(string input)
        {
            var result = StringExtensions.SplitInLines(input);
            CollectionAssert.AreEqual(new[] { input }, result, $"failed for string: '{input}'");
        }
    }
}