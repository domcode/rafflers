namespace Raffler
{
    using System;
    using System.Collections.Generic;
    using System.Linq;

    public class InefficientRandomizer<T> : IRandomItemPicker<T>
    {
        public T PickOne(IEnumerable<T> candidates)
        {
            if (candidates == null) throw new ArgumentNullException(nameof(candidates));
            if (!candidates.Any()) throw new ArgumentException("Can only pick a candidate if there are any.", nameof(candidates));
            return candidates.OrderBy(c => Guid.NewGuid()).First();
        }
    }
}