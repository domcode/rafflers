using System;

namespace Raffler
{
    public static class StringExtensions
    {
        public static string[] SplitInLines(this string input)
        {
            return (input ?? "").Split(new string[] { "\r\n", "\n" }, StringSplitOptions.None);
        }
    }
}