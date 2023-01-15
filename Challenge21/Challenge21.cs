using System;
using System.IO;
using System.Diagnostics;
using System.Text.RegularExpressions;

namespace Year22
{
    public class Day21 {

        private static double calculateValue (double left, double right, char sign) {
                if (sign == '+') {
                    return left+right;
                }
                else if (sign == '-') {
                    return left-right;
                }
                else if (sign == '/') {
                    return left/right;
                }
                else if (sign == '*') {
                    return left*right;
                }
                else if (sign == '=') {
                    if (left > right) {
                        return 2;
                    }
                    if (left < right) {
                        return 1;
                    }
                }
                return 0;
            }


        public static void Run () {
Stopwatch stopwatch = new Stopwatch();
stopwatch.Start();

            //took around 9578 ms to run or approx 32x faster than Powershell
            //powerShell hasn't been calculated, as it's not workin at the moment
            //This was reduced by 60% by calculating the combined values if possible,
            //instead of setting both values and leaving the symbol that way required double loops per line
            //powershell was only reduced by 31% sadly. 
            //one final tweek removed the excess data lines, so it only loops through code it has to calculate. this reduced it even further around another 60%
            //final time was 2200 ms or 45x faster than powershell, even though i reduced powershell 90% c# just reduced far superiorly.
            List<string> data = File.ReadAllLines(@"C:\Tools\advent2022\Challenge21.txt").ToList();
            int count=0;
            string pattern = @"^root:\s\d+$";
            string left;
            string right;
            string leftLong;
            string rightLong;
            string answer = "";
            double tempLonga;
            double tempLongb;
            string sign;
            bool moveOn;
            string name;
            string tempLeft;
            string tempRight;
            double result;
            char tempCharA;
            bool leftCheck;
            bool rightCheck;
            while( ! data.Exists(s => Regex.IsMatch(s, pattern)))
                {
                // increment count 
                count++;
                //initialize VARIABLES
                left = "";
                right = "";
                leftLong = "blank";
                rightLong = "blank";

                //start loop to go through each value in the list of work
                for (int i=0; i < data.Count; i++) {
                    //reset values for left and right
                    left = "";
                    right = "";                    
                    leftLong = "blank";
                    rightLong = "blank";
                    name = data[i].Split(':')[0];
                    if (data.Count(x => x.Contains(name)) == 1 && name != "root" && name != "humn") {
                        data[i] = "";
                    }

                    // determine if we have a sign
                    if (data[i].Split(' ').Length > 2) {
                        sign = data[i].Split(':')[1].Split(' ')[2];
                        //the main name we're at is assigned, then the left and right values
                        left = data[i].Split(':')[1].Split(' ')[1];
                        right =data[i].Split(':')[1].Split(' ').Last();
                        moveOn = true;
                        tempLonga = 0;
                        tempLongb = 0;
                        //try to parse left and right values, if they are numbers, we calculate them
                        leftCheck = double.TryParse(left, out tempLonga);
                        rightCheck = double.TryParse(right, out tempLongb);
                        if (leftCheck && rightCheck) {
                            tempCharA = sign.ToCharArray()[0];
                            
                            answer = calculateValue(tempLonga, tempLongb, tempCharA).ToString();
                            moveOn = false;
                        }
                        if (moveOn) {
                            if (tempLonga == 0) {
                                tempLeft = "^" + left + ":";
                                tempLeft = data.Find(s => Regex.IsMatch(s, tempLeft))!;
                                if (tempLeft.Split(' ').Length == 2) {
                                    if ( double.TryParse(tempLeft.Split(' ')[1], out result) ) {
                                        leftLong = result.ToString();
                                    }
                                }
                            } else {leftLong = tempLonga.ToString();}
                            if (tempLongb == 0) {
                                tempRight = "^" + right + ":";
                                tempRight = data.Find(s => Regex.IsMatch(s, tempRight))!;

                                if (tempRight.Split(' ').Length == 2) {
                                    if ( double.TryParse(tempRight.Split(' ')[1], out result) ) {
                                        rightLong = result.ToString();
                                    }
                                }
                            } else {rightLong = tempLongb.ToString();}
                            if (leftLong != "blank" && rightLong != "blank") {
                                answer = leftLong + " " + sign  + " " + rightLong;
                            }
                            else if (leftLong != "blank" && rightLong == "blank") {
                                answer = leftLong + " " + sign + " " + right;
                            }
                            else if (leftLong == "blank" && rightLong != "blank") {
                                answer = left + " " + sign + " " + rightLong;
                            }
                            else {
                                answer = left + " " + sign + " " + right;
                            }
                        }
                        data[i] = name + ": " + answer;
                    }


                }
                data.RemoveAll(string.IsNullOrEmpty);
            }

            string answer1 = data.Find(s => Regex.IsMatch(s, "root:"))!;
            Console.WriteLine("Answer to 1 = " + answer1);

            //Part 2 works so similarly, but requires retries, that i am restarting

            data = File.ReadAllLines(@"C:\Tools\advent2022\Challenge21.txt").ToList();
            count=0;
            answer = "";
            List<string> dataOld = new List<string> {""};
            bool dataminimized = false;
            //anything bigger than this number breaks c#
            double humanMax = 10000000000000;
            double humanMin = 0;
            bool restart;
            double testValue = 0;
            int trials = 0;
            while( ! data.Exists(s => Regex.IsMatch(s, pattern)))
            {
                //     Console.WriteLine();
                // foreach (string line in data) {
                //     Console.WriteLine(line);
                // }
                if (!dataminimized) { 
                    if (dataOld.SequenceEqual(data)) {dataminimized = true;}
                    
                    if (data.Count(x => x.Contains("humn")) == 2) {
                        dataOld = new List<string>(data);
                    }
                }
                restart = false;
                // increment count 
                count++;
                //start loop to go through each value in the list of work
                testValue = Math.Round((humanMax + humanMin) / 2);
                if (dataminimized) {
                    int index = data.FindIndex(s => s.Contains("humn:"));
                    data[index] = "humn: " + testValue.ToString();
                }

                for (int i=0; i < data.Count; i++) {
                    //reset values for left and right
                    if (!dataminimized) {
                        if (data[i].Contains("humn")) {continue;}
                    }
                    name = data[i].Split(':')[0];
                    if (data.Count(x => x.Contains(name)) == 1 && name != "root" && name != "humn") {
                        data[i] = "";
                    }
                    // determine if we have a sign
                    if (data[i].Split(' ').Length > 2) {
                        sign = data[i].Split(':')[1].Split(' ')[2];
                        left = "";
                        right = "";
                        leftLong = "blank";
                        rightLong = "blank";
                        //the main name we're at is assigned, then the left and right values
                        left = data[i].Split(':')[1].Split(' ')[1];
                        right =data[i].Split(':')[1].Split(' ').Last();
                        moveOn = true;
                        tempLonga = 0;
                        tempLongb = 0;
                        //try to parse left and right values, if they are numbers, we calculate them
                        
                        leftCheck = double.TryParse(left, out tempLonga);
                        rightCheck = double.TryParse(right, out tempLongb);
                        if (leftCheck && rightCheck && name != "root") {
                            tempCharA = sign.ToCharArray()[0];
                            
                            answer = calculateValue(tempLonga, tempLongb, tempCharA).ToString();
                        }
                        else {
                            if (tempLonga == 0) {
                                tempLeft = "^" + left + ":";
                                tempLeft = data.Find(s => Regex.IsMatch(s, tempLeft))!;
                                if (tempLeft.Split(' ').Length == 2) {
                                    if ( double.TryParse(tempLeft.Split(' ')[1], out result) ) {
                                        leftLong = result.ToString();
                                    }
                                }
                            } else {leftLong = tempLonga.ToString();}
                            if (tempLongb == 0) {
                                tempRight = "^" + right + ":";
                                tempRight = data.Find(s => Regex.IsMatch(s, tempRight))!;

                                if (tempRight.Split(' ').Length == 2) {
                                    if ( double.TryParse(tempRight.Split(' ')[1], out result) ) {
                                        rightLong = result.ToString();
                                    }
                                }
                            } else {rightLong = tempLongb.ToString();}
                            if (leftLong != "blank" && rightLong != "blank") {
                                if (name == "root" && calculateValue(double.Parse(leftLong), double.Parse(rightLong), '=') == 0) {
                                    answer = testValue.ToString();
                                }
                                else if (name == "root" && calculateValue(double.Parse(leftLong), double.Parse(rightLong), '=') == 1) {
                                    humanMax = testValue;
                                    data = new List<string>(dataOld);
                                    restart = true;
                                }
                                else if (name == "root" && calculateValue(double.Parse(leftLong), double.Parse(rightLong), '=') == 2) {
                                    humanMin = testValue;
                                    data = new List<string>(dataOld);
                                    restart = true;
                                }

                                else {
                                    answer = calculateValue(double.Parse(leftLong), double.Parse(rightLong), char.Parse(sign)).ToString(); //leftLong + " " + sign  + " " + rightLong;
                                }

                            }
                            else if (leftLong != "blank" && rightLong == "blank") {
                                answer = leftLong + " " + sign + " " + right;
                            }
                            else if (leftLong == "blank" && rightLong != "blank") {
                                answer = left + " " + sign + " " + rightLong;
                            }
                            else {
                                answer = left + " " + sign + " " + right;
                            }
                        }
                        if (restart) {
                            trials++;
                            //it takes 41 or so rounds, this helps see time
//                            Console.WriteLine("Finished Round " + trials);
                            break;
                        }
                        data[i] = name + ": " + answer;

                    }


                }
                data.RemoveAll(string.IsNullOrEmpty);

            }
            Console.WriteLine("Answer to 2 = " + answer);


stopwatch.Stop();
TimeSpan elapsed = stopwatch.Elapsed;
double elapsedMilliseconds = elapsed.TotalMilliseconds;
double elapsedSeconds = elapsed.TotalSeconds;

Console.WriteLine("Elapsed time: {0} milliseconds ({1} seconds)", elapsedMilliseconds, elapsedSeconds);
        }

    }

}