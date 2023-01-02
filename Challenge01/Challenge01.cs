using System;
using System.IO;
using System.Diagnostics;

namespace Year22
{
    public class Day01 {
        public static void Run () {
Stopwatch stopwatch = new Stopwatch();
stopwatch.Start();


            List<string> calories = File.ReadAllLines(@"C:\tools\advent2022\Challenge1.txt").ToList();

            calories.Add("");
            int sum = 0;
            int maxsum = 0;
            List<int> elves = new List<int>();

            foreach (var calorie in calories) {
                if (calorie == "") {
                    elves.Add(sum);
                    maxsum = Math.Max(sum , maxsum);
                    sum = 0;
                }
                else {
                    sum += int.Parse(calorie);
                }
            }
            sum = 0;
            elves.Sort();
            foreach (var a in elves.GetRange(elves.Count - 3, 3)) {
                sum += a;
            }

            Console.WriteLine("Answer 1 is " + maxsum);
            Console.WriteLine("Answer 2 is " + sum);


stopwatch.Stop();
TimeSpan elapsed = stopwatch.Elapsed;
double elapsedMilliseconds = elapsed.TotalMilliseconds;
double elapsedSeconds = elapsed.TotalSeconds;

Console.WriteLine("Elapsed time: {0} milliseconds ({1} seconds)", elapsedMilliseconds, elapsedSeconds);
        }

    }

}