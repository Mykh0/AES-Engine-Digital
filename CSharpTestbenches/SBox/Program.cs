using System;
using System.Collections.Generic;
using System.Globalization;
using System.Linq;

namespace SBox
{
  class Program
  {
    static void Main(string[] args)
    {
      var testVectorList = new List<string>() { "00102030405060708090a0b0c0d0e0f0", "89d810e8855ace682d1843d8cb128fe4", "4915598f55e5d7a0daca94fa1f0a63f7", "fa636a2825b339c940668a3157244d17" };
      var resultList = new List<string>() { "63cab7040953d051cd60e0e7ba70e18c", "a761ca9b97be8b45d8ad1a611fc97369", "3b59cb73fcd90ee05774222dc067fb68", "2dfb02343f6d12dd09337ec75b36e3f0" };

      for(int j = 0; j < 2; j++)
      {
        string testVector = testVectorList.ElementAt(j);
        string sboxResult = resultList.ElementAt(j);

        Console.WriteLine($"s_in <= x\"{testVector}\";");
        Console.WriteLine($"wait for delay;");
        Console.WriteLine($"assert s_out = x\"{sboxResult}\" report \"Sbox wrong output\" severity error;");
      }

      var key = Console.ReadKey();

      if(key.Key == ConsoleKey.Q)
      {
        return;
      }
    }
  }
}
