// A purposely over-engineered raffler!

namespace Raffler
{
    public class Candidate
    {
        private readonly static string[] tagLines = new[] {
            "The Hero The World Needed",
            "Most Awesome of The Human Race",
            "The Monarch of Greatness",
            "Samuarai with a Keyboard",
            "Chef of Chefs",
            "Boss of the Bosses",
            "Slayer of Bugs",
            "Jack of All Trades, Master of None",
            "Ender of Bugs",
            "The Agile Bug Hunter",
            "The FactoryFactory Killer",
            "Luckdestroyer",
            "a.k.a. the 'There Are ZERO Hard Problems in Computer Programming' don",
            "Cacheblamer",
        };

        private static int i = 0;

        private static object lockObject = new object();

        private static string GetNextTagLine()
        {
            string result = "";
            lock (lockObject)
            {
                result = tagLines[i++];
                if (i > tagLines.Length - 1)
                {
                    i = 0;
                }
            }
            return result;
        }

        public Candidate(string name)
        {
            this.Name = name;
            this.TagLine = GetNextTagLine();
        }

        public string Name { get; set; }

        public string TagLine { get; set; }

        public override string ToString() => $"{Name}, {TagLine}".ToUpperInvariant();

        static public implicit operator Candidate(string candidateName)
        {
            return new Candidate(candidateName);
        }

        static public Candidate AsCandidate(string candidateName)
        {
            return new Candidate(candidateName);
        }
    }
}
