// A purposely over-engineered raffler!

namespace Raffler
{
    using System;
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
            var candidates = CandidatesSource.GetCandidates(args[0]);
            var raffler = new Raffler(randomizer, candidates);

            try
            {
                var winner = raffler.Raffle();
                
                // It would be awesome if we could do this:
                // WriteLine($"{winner}, chosen by a(n) {randomizer.GetType().Name}.");
                // However, the current build/test system for rafflers does
                // not support this yet.
                // So we do the boring thing, for now:
                WriteLine(winner.Name);
            }
            catch (NoMoreCandidatesException)
            {
                // This seems silly, but the Raffler was actually originally built with
                // support for multi-raffling (e.g. "Pick another winner? [Y/n]"), but
                // the way Rafflers are run with a container is not interactive.
                //
                // We leave this here though, so we may one day resurrect this code!

                WriteLine("There's no one left to win!");
            }
        }
    }
}
