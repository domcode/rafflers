namespace Raffler.Tests
{
    using System;
    using System.IO;
    using System.Linq;
    using Microsoft.VisualStudio.TestTools.UnitTesting;

    [TestClass]
    public class CandidatesSourceTests
    {
        [TestMethod]
        public void GetCandidates_throws_if_file_does_not_exist()
        {
            var nonExistentPath = GetPathToNonExistentFile();
            var exception = Assert.ThrowsException<ArgumentException>(
                () => CandidatesSource.GetCandidates(nonExistentPath)
            );
            StringAssert.Contains(exception.Message, nonExistentPath);
            Assert.AreEqual("path", exception.ParamName);
        }

        [TestMethod]
        public void GetCandidates_can_get_single_candidate()
        {
            var path = WriteLinesToNewPath("John");
            var result = CandidatesSource.GetCandidates(path).Select(c => c.Name).ToArray();
            CollectionAssert.AreEqual(new[] { "John" }, result);
        }

        [TestMethod]
        public void GetCandidates_can_get_multiple_candidates()
        {
            var path = WriteLinesToNewPath("John", "Dave" );
            var result = CandidatesSource.GetCandidates(path).Select(c => c.Name).ToArray();
            CollectionAssert.AreEqual(new[] { "John", "Dave" }, result);
        }

        [TestMethod]
        public void GetCandidates_ignores_empty_lines()
        {
            var path = WriteLinesToNewPath("John", "", "   ", "Dave", "\t");
            var result = CandidatesSource.GetCandidates(path).Select(c => c.Name).ToArray();
            CollectionAssert.AreEqual(new[] { "John", "Dave" }, result);
        }

        private static string WriteLinesToNewPath(params string[] lines)
        {
            var path = Path.GetTempFileName();
            File.WriteAllLines(path, lines);
            return path;
        }

        private static string GetPathToNonExistentFile()
        {
            // Dont' be tempted to use Path.GetTempFileName() because that
            // actually *creates* the file on disk.

            return Path.Combine(
                Path.GetTempPath(),
                Path.GetRandomFileName()
            );
        }
    }
}