using System;
using System.IO;

namespace GenerateTestbenches
{
  class Program
  {
    static void Main(string[] args)
    {
      var reader = new StreamReader("test.txt");
      string data = reader.ReadToEnd();
      string testBench = "";

      data = data.Replace("\n", "").Replace("\r", "");

      while(data.Contains("im_col"))
      {
        int dataFlag = data.IndexOf("is_row");
        int resultFlag = data.IndexOf("im_col");
        dataFlag++;
        resultFlag++;
        string test = data.Remove(dataFlag, 6).Substring(dataFlag, 32);
        string result = data.Remove(resultFlag, 6).Substring(resultFlag, 32);

        data = data.Remove(0, resultFlag + 38);
        testBench += $"RawData <= x\"{test}\";\n";
        testBench += $"wait for delay;\n";
        testBench += $"foo := ass(x\"{result}\");\n\n";
      }

      File.WriteAllText("result.txt", testBench);
    }
  }
}
