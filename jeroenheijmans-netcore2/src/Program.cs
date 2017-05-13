// A purposely over-engineered raffler!

namespace Raffler
{
    using System;
    using System.Collections.Generic;
    using System.IO;
    using System.Linq;
    using static System.Console;

    public class Program
    {
        public static void Main(string[] args)
        {
            if (args.Length == 0)
            {
                throw new InvalidOperationException("Please provide path to the candidates as the first argument.");
            }

            var randomizer = new InefficientRandomizer<Candidate>();
            var candidates = GetCandidates(args[0]);
            var raffler = new Raffler(randomizer, candidates);

            try
            {
                var winner = raffler.Raffle();
                WriteLine($"{winner}, chosen by a(n) {randomizer.GetType().Name}.");
            }
            catch (NoMoreCandidatesException)
            {
                WriteLine("There's no one left to win!");
            }
        }

        private static IEnumerable<Candidate> GetCandidates(string path)
        {
            if (!File.Exists(path))
            {
                throw new ArgumentException($"No file at {path} exists.");
            }

            return File.ReadAllText(path)
                .SplitInLines()
                .Select(Candidate.AsCandidate);
        }
    }
}
