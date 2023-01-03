using System;
using System.IO;
using System.Diagnostics;

namespace Year22
{
    public class Day02 {
        public static void Run () {
Stopwatch stopwatch = new Stopwatch();
stopwatch.Start();
            string[] games = File.ReadAllLines(@"C:\Tools\advent2022\challenge2.txt").ToArray();
            int score = 0;
            int score2 = 0;

            // a = rock, b = paper, c = scissors
            // x = rock, Y = paper, Z = scissors
            // you chose - 1 pt for rock, 2 for paper, 3 for scissors
            // outcome - 0 pts to lose, 3 to tie, 6 to win
            Dictionary<string, int> scoreHash = new Dictionary<string, int>() {
                {"A X", 4},{"A Y", 8},{"A Z", 3},{"B X", 1},{"B Y", 5},{"B Z", 9},{"C X", 7},{"C Y", 2},{"C Z", 6}
            };

            // a = rock, b = paper, c = scissors
            // x = lose, Y = tie, Z = win
            // you chose - 1 pt for rock, 2 for paper, 3 for scissors
            // outcome - 0 pts to lose, 3 to tie, 6 to win
            Dictionary<string, int> score2Hash = new Dictionary<string, int>() {
                {"A X", 3},{"A Y", 4},{"A Z", 8},{"B X", 1},{"B Y", 5},{"B Z", 9},{"C X", 2},{"C Y", 6},{"C Z", 7}
            };

            foreach (string round in games) {
                score += scoreHash[round];
                score2 += score2Hash[round];
            }
            Console.WriteLine("Answer 1 = " + score);
            Console.WriteLine("Answer 2 = " + score2);

stopwatch.Stop();
TimeSpan elapsed = stopwatch.Elapsed;
double elapsedMilliseconds = elapsed.TotalMilliseconds;
double elapsedSeconds = elapsed.TotalSeconds;

Console.WriteLine("Elapsed time: {0} milliseconds ({1} seconds)", elapsedMilliseconds, elapsedSeconds);
        }

    }

}