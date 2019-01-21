using System;
using System.IO;

namespace WriteDoFile
{
  class Program
  {
    static void Main(string[] args)
    {
      using(StreamWriter writer = new StreamWriter("invertaestest.do"))
      {
        string dofile = "restart -f\n";
        int testcase = 0;

        while(testcase < 256)
        {
          dofile = $"{dofile}force data_in 16#{testcase.ToString("X2")}\nrun 100\n";
          testcase++;
        }
        
        writer.Write(dofile);
      }
    }
  }
}
