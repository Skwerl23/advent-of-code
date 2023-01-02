using System;
using System.IO;
using System.Diagnostics;

namespace Year22
{
    public class Day04 {
        public static void Run () {
Stopwatch stopwatch = new Stopwatch();
stopwatch.Start();
            List<string> ranges = File.ReadAllLines(@"C:\tools\advent2022\Challenge4.txt").ToList();
            int count = 0;
            foreach (string line in ranges) {
                string[] parts = line.Split(new char[] {'-',','} );
                int a = int.Parse(parts[0]);
                int b = int.Parse(parts[1]);
                int c = int.Parse(parts[2]);
                int d = int.Parse(parts[3]);
                bool z = false;

                for (int x=a; x <= b; x++) {
                    for (int y=c; y <= d; y++) {
                        z=(x == y);
                        if (z){break;}
                    }
                    if (z){break;}
                }
                count += z ? 1: 0;
            }
            Console.WriteLine("Answer 2 is " + count);


stopwatch.Stop();
TimeSpan elapsed = stopwatch.Elapsed;
double elapsedMilliseconds = elapsed.TotalMilliseconds;
double elapsedSeconds = elapsed.TotalSeconds;

Console.WriteLine("Elapsed time: {0} milliseconds ({1} seconds)", elapsedMilliseconds, elapsedSeconds);
        }

    }

}