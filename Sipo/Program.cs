using System;
using System.IO;

namespace Sipo
{
  class Program
  {
    static void Main(string[] args)
    {
      string systemPath = "tests/sipo.txt";
      string test = "";
      string testvector = new string('0', 256);

      Random _random = new Random();

      for(int i = 0; i < 5000; i++)
      {
        int random = _random.Next() % 2;

        testvector = testvector.Remove(0, 1) + random.ToString();
        test += $"SerialIn <= '{random}';\n";
        test += $"wait for fullClk;\n";
        test += $"assert ParallelOut = b\"{testvector}\" report \"sipo has the wrong output\" severity failure;\n";
        Console.WriteLine(i);
      }
        
      using(StreamWriter writer = new StreamWriter(systemPath))
      {
        writer.Write(test);
      }
    }
  }
}
