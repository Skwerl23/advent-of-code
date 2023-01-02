using System;
using System.IO;
using System.Diagnostics;

namespace Year22
{
    public class Day05 {
        public static void Run () {
Stopwatch stopwatch = new Stopwatch();
stopwatch.Start();
            List<string> rules = File.ReadAllLines(@"C:\tools\advent2022\Challenge5.txt").ToList();

            List<string> stacks = new List<string>(rules.Take(9).ToArray());
            List<string> moves = new List<string>(rules.Skip(10).Take(rules.Count - 10).ToArray());

            List<List<char>> a = new List<List<char>>();
            for (int x = 0; x < 9;x++) {
                a.Add(new List<char>());
            }

            for (int x = 0; x < 8;x++) {
                for (int i = 0; i < 9;i++) {
                    if (stacks[x][(i*4)+1] != ' ') {
                        a[i].Add(stacks[x][(i*4)+1]);
                    }
                }
            }

            foreach (string m in moves) {
                int x = int.Parse(m.Split(' ')[3]) - 1;
                int y = int.Parse(m.Split(' ')[5]) - 1;
                for (int q = 0; q < int.Parse(m.Split(' ')[1]); q++) {
                // Requires a check on length, if the stack is empty this crashes out. Luckily Insert(0, value) works on an empty List
                    if (a[x].Count > 0) {
                        a[y].Insert(0, a[x][0]);
                        a[x].RemoveAt(0);
                    }
                }

            }
 
            List<char> answer = new List<char>();
            for (int x = 0; x < 9;x++) {
                // Requires a check on length, if the stack is empty this crashes out.
                if (a[x].Count > 0 ) {
                    answer.Add(a[x][0]);
                }
            }
            Console.WriteLine(String.Join("", answer));



stopwatch.Stop();
TimeSpan elapsed = stopwatch.Elapsed;
double elapsedMilliseconds = elapsed.TotalMilliseconds;
double elapsedSeconds = elapsed.TotalSeconds;

Console.WriteLine("Elapsed time: {0} milliseconds ({1} seconds)", elapsedMilliseconds, elapsedSeconds);
        }

    }

}