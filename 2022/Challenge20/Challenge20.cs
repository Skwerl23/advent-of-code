using System;
using System.IO;
using System.Diagnostics;

namespace Year22
{
    public class Day20 {
        public static void Run () {
Stopwatch stopwatch = new Stopwatch();
stopwatch.Start();

        // This took approx 292 milliseconds or about 9x faster than powershell


        List<string> data = File.ReadAllLines(@"C:\Tools\advent2022\Challenge20.txt").ToList();

        // data = @("1"
        // "2"
        // "-3"
        // "3"
        // "-2"
        // "0"
        // "4")

        List<double> indexes = new List<double> {};
        for (double i = 0; i < data.Count; i++) {
            indexes.Add(i);
        }

        for (int i = 0; i < data.Count; i++) {
            double move = double.Parse(data[i]);
            int index = indexes.IndexOf(i);
            // interestingly anything above a multiplier of 100000 breaks it?
            double tempnewindex = index + move + ((data.Count - 1)*100000);
            int newindex = (int)(tempnewindex % (data.Count -1));
            double value = indexes[index];
            indexes.RemoveAt(index);
            indexes.Insert(newindex, value);
        }

        List<double> answer = new List<double> {}; 
        foreach (int item in indexes) {
            answer.Add(double.Parse(data[item]));
        }
        int zeroIndex = answer.IndexOf(0);
        Console.WriteLine("Answer 1 = " + (answer[(zeroIndex+1000)%(data.Count)] + answer[(2000+zeroIndex)%(data.Count)] + answer[(3000+zeroIndex)%(data.Count)]));

        // Part 2, i find it easier to work each one separate, but it is possible to just make new arrays for each half.

        data = File.ReadAllLines(@"C:\Tools\advent2022\Challenge20.txt").ToList();
        indexes = new List<double> {};
        for (int i = 0; i < data.Count ; i++) {
            indexes.Add(i);
            data[i] = (double.Parse(data[i]) * 811589153).ToString();
        }
        for (int z = 0; z < 10; z++) {
                for (int i = 0; i < data.Count; i++) {
                double move = double.Parse(data[i]);
                int index = indexes.IndexOf(i);
                double tempnewindex = index + move + (data.Count - 1)*10000;
                int newindex = (int)(tempnewindex % (data.Count -1));
                while (newindex <= 0) {newindex += (data.Count - 1);}
                double value = indexes[index];
                indexes.RemoveAt(index);
                indexes.Insert(newindex, value);
            }
        }
        answer = new List<double>{};
        int count = 0;
        foreach (int item in indexes) {
            if (data[item] == "0") {
                zeroIndex = count;
            }
                count++;
            answer.Add(double.Parse(data[item]));
        }
        Console.WriteLine("Answer 2 = " + (answer[(zeroIndex+1000)%(data.Count)] + answer[(2000+zeroIndex)%(data.Count)] + answer[(3000+zeroIndex)%(data.Count)]));


stopwatch.Stop();
TimeSpan elapsed = stopwatch.Elapsed;
double elapsedMilliseconds = elapsed.TotalMilliseconds;
double elapsedSeconds = elapsed.TotalSeconds;

Console.WriteLine("Elapsed time: {0} milliseconds ({1} seconds)", elapsedMilliseconds, elapsedSeconds);
        }

    }

}