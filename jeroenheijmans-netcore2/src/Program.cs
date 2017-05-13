// A purposely over-engineered raffler!

namespace Raffler
{
    using System;
    using System.Collections.Generic;
    using static System.Console;

    class Program
    {
        static void Main(string[] args)
        {
            var randomizer = new InefficientRandomizer<Candidate>();
            var candidates = GetCandidates();
            var raffler = new Raffler(randomizer, candidates);

            do
            {
                try
                {
                    SelectWinner(raffler);
                }
                catch (NoMoreCandidatesException)
                {
                    WriteLine("Everybody's already one! So everybody's getting another turn!");
                    raffler.Reset();
                    SelectWinner(raffler);
                }

                WriteLine("Press Q to quit, or any other key to pick another winner!");

            } while (ReadKey(true).Key.ToString().ToLowerInvariant() != "q");
        }

        private static void SelectWinner(Raffler raffler)
        {
            WriteLine();
            var winner = raffler.Raffle();
            WriteLine(winner);
            WriteLine();
        }

        static IEnumerable<Candidate> GetCandidates()
        {
            return new Candidate[] { "JohnDoe", "Marc", "pieter de man" };
        }
    }
}
