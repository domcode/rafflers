namespace Raffler 
{
    using System;
    using System.Collections.Generic;
    using System.IO;
    using System.Linq;

    public static class CandidatesSource
    {
        public static IEnumerable<Candidate> GetCandidates(string path)
        {
            if (!File.Exists(path))
            {
                throw new ArgumentException($"No file at {path} exists.", nameof(path));
            }

            return File.ReadAllText(path)
                .SplitInLines()
                .Where(s => !String.IsNullOrWhiteSpace(s))
                .Select(Candidate.AsCandidate);
        }
    }
}