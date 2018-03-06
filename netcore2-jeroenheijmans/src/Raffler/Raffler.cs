namespace Raffler
{
    using System;
    using System.Collections.Generic;
    using System.Linq;

    public class Raffler : IRaffler
    {
        private readonly IRandomItemPicker<Candidate> randomizer;
        private readonly IList<Candidate> candidates;

        // By default, if you raffle twice, the second time a previous
        // winner will not be eligible. Call "Reset" to fix this.
        private IList<Candidate> previousWinners = new List<Candidate>();

        public Raffler(
            IRandomItemPicker<Candidate> randomizer,
            IEnumerable<Candidate> candidates)
        {
            if (randomizer == null) throw new ArgumentNullException(nameof(randomizer));
            if (candidates == null) throw new ArgumentNullException(nameof(candidates));
            if (!candidates.Any()) throw new ArgumentException("Cannot have a raffler without candidates.");

            this.candidates = candidates.ToList();
            this.randomizer = randomizer;
        }

        public void Reset()
        {
            this.previousWinners.Clear();
        }

        public Candidate Raffle()
        {
            var leftOverCandidates = candidates.Except(previousWinners);

            if (!leftOverCandidates.Any())
            {
                throw new NoMoreCandidatesException($"All {candidates.Count()} candidates have already one before. Call Reset first to start with a clean slate!");
            }

            var winner = randomizer.PickOne(leftOverCandidates);

            previousWinners.Add(winner);

            return winner;
        }
    }
}
