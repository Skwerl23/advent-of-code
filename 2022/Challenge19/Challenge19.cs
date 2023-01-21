using System;
using System.IO;
using System.Diagnostics;

namespace Year22
{
    public class Day19 {
        static int maxGeodes = 0;
        static Dictionary<int, int> pruneMins = new Dictionary<int, int>();        
        private static void findMaxGeodes(Tuple<int, int> oreCost, Tuple<int, int> clayCost, Tuple<int, int> obsidianCost, Tuple<int, int> geodeCost, int oreRobots, int clayRobots, int obsidianRobots, int geodeRobots, int ore, int clay, int obsidian, int geode, int timeLeft) {
            timeLeft -= 1;

            if (timeLeft < 0) {
                return;
            }

            ore += oreRobots;
            clay += clayRobots;
            obsidian += obsidianRobots;
            geode += geodeRobots;

            if (pruneMins[timeLeft] < geode + 1) {
                pruneMins[timeLeft] = geode;
            }
            // for some reason i have to prune a little less aggressively
            // this makes no sense to me, but it allows an extra layer of checking which fixes my lvl 27
            else if (pruneMins[timeLeft] < geode + 2) {}
            else {
                return;
            }
            if (geode > maxGeodes) {
                maxGeodes = geode;
            }

            //try making a geode robot
            if (ore >= geodeCost.Item1 && obsidian >= geodeCost.Item2) {
                findMaxGeodes(oreCost, clayCost, obsidianCost, geodeCost, oreRobots, clayRobots, obsidianRobots, geodeRobots +1, 
                ore -geodeCost.Item1, clay, obsidian -geodeCost.Item2, geode -1 , timeLeft);
                //no other bot matters, so return
                return;
            }

            //try making an obsidian robot
            if (ore >= obsidianCost.Item1 && clay >= obsidianCost.Item2) {
                findMaxGeodes(oreCost, clayCost, obsidianCost, geodeCost, oreRobots, clayRobots, obsidianRobots+1, geodeRobots, 
                ore - obsidianCost.Item1, clay-obsidianCost.Item2, obsidian-1, geode, timeLeft);
                //no other lower bot matters, so return
                return;
            }
            //try making a clay robot
            if (ore >= clayCost.Item1) {
                findMaxGeodes(oreCost, clayCost, obsidianCost, geodeCost, oreRobots, clayRobots + 1 , obsidianRobots, geodeRobots, 
                ore - clayCost.Item1, clay-1, obsidian, geode, timeLeft);
            }
            //try making an ore robot
            if (ore >= oreCost.Item1) {
                findMaxGeodes(oreCost, clayCost, obsidianCost, geodeCost, oreRobots + 1, clayRobots, obsidianRobots, geodeRobots, 
                ore - oreCost.Item1 - 1, clay, obsidian, geode, timeLeft);
            }
            findMaxGeodes(oreCost, clayCost, obsidianCost, geodeCost, oreRobots, clayRobots, obsidianRobots, geodeRobots, ore , clay, obsidian, geode, timeLeft);
            return;
        }



        public static void Run () {
Stopwatch stopwatch = new Stopwatch();
stopwatch.Start();

        //this whole function takes around 569000 milliseconds to run (about 7-8 minutes)
        // haven't created on powershell yet
        //need to optimize, probably something to do with waiting to produce each type so
        //something like if not enough ore, just fast track it to make more ore bots. and clay bots
        List<string> data = File.ReadAllLines(@"C:\Tools\advent2022\Challenge19.txt").ToList();

        int answer = 0;
        int answerTwo = 1;
        for (int i=0; i < data.Count; i++) {
            Console.WriteLine("Working on blueprint " + (i+1) + " of " + data.Count);
            string line = data[i];
            // string blueprint = line.Split(' ')[1];
            Tuple<int, int> oreCost = new Tuple<int, int>(int.Parse(line.Split(' ')[6]), 0);
            Tuple<int, int> clayCost = new Tuple<int, int>(int.Parse(line.Split(' ')[12]), 0);
            Tuple<int, int> obsidianCost = new Tuple<int, int>(int.Parse(line.Split(' ')[18]), int.Parse(line.Split(' ')[21]));
            Tuple<int, int> geodeCost = new Tuple<int, int>(int.Parse(line.Split(' ')[27]), int.Parse(line.Split(' ')[30]));
            maxGeodes = 0;
            pruneMins = new Dictionary<int, int>();
            for (int x = 0; x <= 32; x++) {
                pruneMins[x] = 0;
            }
            findMaxGeodes(oreCost, clayCost, obsidianCost, geodeCost, 1, 0, 0, 0, 0, 0, 0, 0, 24);
            //uncomment for debugging
            //  Console.WriteLine(maxGeodes*(i+1));
            answer += (i+1)*maxGeodes;
            if (i < 3) {
                Console.WriteLine("part 2");
                findMaxGeodes(oreCost, clayCost, obsidianCost, geodeCost, 1, 0, 0, 0, 0, 0, 0, 0, 32);
                answerTwo *= maxGeodes;
            }

        }
        Console.WriteLine("Answer 1 = " + answer);
        Console.WriteLine("Answer 2 = " + answerTwo);
stopwatch.Stop();
TimeSpan elapsed = stopwatch.Elapsed;
double elapsedMilliseconds = elapsed.TotalMilliseconds;
double elapsedSeconds = elapsed.TotalSeconds;

Console.WriteLine("Elapsed time: {0} milliseconds ({1} seconds)", elapsedMilliseconds, elapsedSeconds);
        }

    }

}