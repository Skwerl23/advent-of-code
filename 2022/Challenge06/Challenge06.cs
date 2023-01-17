using System;
using System.IO;
using System.Diagnostics;

namespace Year22
{
    public class Day06 {
        public static void Run () {
Stopwatch stopwatch = new Stopwatch();
stopwatch.Start();
            // Took 13 ms to run or about 120x faster than Powershell
            List<char> signal = new List<char>(File.ReadAllText(@"C:\Tools\advent2022\challenge6.txt").ToCharArray());
            for (int turn = 0; turn < 2; turn++) {
                int gap = turn*10 + 4;
                for (int num = 0; num < signal.Count; num++) {
                    List<char> list = new List<char>();
                    for (int i = 0; i < gap; i++) {
                        list.Add(signal[num+i]);
                    }
                    if (list.Distinct().Count() == gap) {
                        Console.WriteLine("Answer " + (turn+1) +  " = " + (num+gap) );
                        break;
                    }
                }
            }

stopwatch.Stop();
TimeSpan elapsed = stopwatch.Elapsed;
double elapsedMilliseconds = elapsed.TotalMilliseconds;
double elapsedSeconds = elapsed.TotalSeconds;

Console.WriteLine("Elapsed time: {0} milliseconds ({1} seconds)", elapsedMilliseconds, elapsedSeconds);
        }

    }

}