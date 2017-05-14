using System;
using System.Collections.Generic;
using System.Linq;

namespace Raffler.Tests
{
    internal class FakeRandomizer : IRandomItemPicker<Candidate>
    {
        private Func<IEnumerable<Candidate>, Candidate> picker = candidates => candidates.FirstOrDefault();

        public Candidate PickOne(IEnumerable<Candidate> candidates)
        {
            return picker(candidates);
        }

        public FakeRandomizer AlwaysReturningItemAtIndex(int index)
        {
            picker = candidates => candidates.ToArray()[index];
            return this;
        }
    }
}