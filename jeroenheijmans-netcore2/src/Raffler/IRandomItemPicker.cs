namespace Raffler
{
    using System.Collections.Generic;
    
    public interface IRandomItemPicker<T>
    {
        T PickOne(IEnumerable<T> candidates);
    }
}
