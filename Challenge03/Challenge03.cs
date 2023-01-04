using System;
using System.IO;
using System.Diagnostics;

namespace Year22 {
    public class Day03 {
        public static void Run () {

Stopwatch stopwatch = new Stopwatch();
stopwatch.Start();
            // Took around 7.1ms to run or about 680x faster than Powershell
            List<string> rucksacks = File.ReadAllLines(@"C:\Tools\advent2022\challenge3.txt").ToList();
            int valuecount = 0;
            List<char> letters = new List<char>()
                        {'a','b','c','d','e','f','g','h','i','j','k','l','m',
                         'n','o','p','q','r','s','t','u','v','w','x','y','z',
                         'A','B','C','D','E','F','G','H','I','J','K','L','M',
                         'N','O','P','Q','R','S','T','U','V','W','X','Y','Z'};
            
            foreach (string ruck in rucksacks) {
                int count = ruck.Length;
                string half1 = (ruck.Substring(0,( (count / 2) )));
                string half2 = (ruck.Substring( (count / 2) ));
                foreach (char letter in letters) {
                    if (half1.Contains(letter) && half2.Contains(letter)) {
                        valuecount += letters.IndexOf(letter) + 1;
                    }
                }
            }
            Console.WriteLine("Answer 1 = " + valuecount);

            valuecount = 0;
            for (int ruck = 0; ruck < rucksacks.Count / 3; ruck++) {
                char[] c = rucksacks[(ruck*3) + 2].ToCharArray();
                char[] b = rucksacks[(ruck*3) + 1].ToCharArray();
                char[] a = rucksacks[ruck*3].ToCharArray();
                foreach (char letter in letters) {
                    if (a.Contains(letter) && b.Contains(letter) && c.Contains(letter)) {
                            valuecount += letters.IndexOf(letter) + 1;
                    }
                }       
            }

            Console.WriteLine("Answer 2 = " + valuecount);

stopwatch.Stop();
TimeSpan elapsed = stopwatch.Elapsed;
double elapsedMilliseconds = elapsed.TotalMilliseconds;
double elapsedSeconds = elapsed.TotalSeconds;

Console.WriteLine("Elapsed time: {0} milliseconds ({1} seconds)", elapsedMilliseconds, elapsedSeconds);

        }

    }

}