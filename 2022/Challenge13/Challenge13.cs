using System;
using System.IO;
using System.Diagnostics;

namespace Year22
{
    public class Day13 {
        public static void Run () {
Stopwatch stopwatch = new Stopwatch();
stopwatch.Start();
            Console.WriteLine("Nothing Written Yet");

stopwatch.Stop();
TimeSpan elapsed = stopwatch.Elapsed;
double elapsedMilliseconds = elapsed.TotalMilliseconds;
double elapsedSeconds = elapsed.TotalSeconds;

Console.WriteLine("Elapsed time: {0} milliseconds ({1} seconds)", elapsedMilliseconds, elapsedSeconds);
        }

    }

}