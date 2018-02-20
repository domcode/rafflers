namespace Raffler
{
    using System;
    
    public class NoMoreCandidatesException : Exception
    { 
        public NoMoreCandidatesException(string message) 
            : base(message) 
        {            
        }
    }
}
