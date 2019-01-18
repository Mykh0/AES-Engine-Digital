using System;
using System.Text.RegularExpressions;

namespace GenerateTestVectors
{
  class Program
  {
    static void Main(string[] args)
    {
      while(true)
      {
        Console.WriteLine("MixColumns test vector:");
        string input = Console.ReadLine();

        input = Regex.Replace(input, @"\s+", "");
        input = input.Substring(0, 2)
                + input.Substring(8, 2)
                + input.Substring(16, 2)
                + input.Substring(24, 2)

                + input.Substring(2, 2)
                + input.Substring(10, 2)
                + input.Substring(18, 2)
                + input.Substring(26, 2)

                + input.Substring(4, 2)
                + input.Substring(12, 2)
                + input.Substring(20, 2)
                + input.Substring(28, 2)

                + input.Substring(6, 2)
                + input.Substring(14, 2)
                + input.Substring(22, 2)
                + input.Substring(30, 2);

        Console.WriteLine(input);
      }
    }
  }
}
