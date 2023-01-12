using System;
using System.IO;
using System.Diagnostics;
using System.Text.RegularExpressions;

namespace Year22
{
    public class Day21 {

        private static ulong calculateValue (ulong left, ulong right, char sign) {
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

            //took around 26513 ms to run or approx 32x faster than Powershell
            //this is using a different search algorithm.
            List<string> data = File.ReadAllLines(@"C:\Tools\advent2022\Challenge21.txt").ToList();
            int count=0;
            string pattern = @"^root:\s\d+$";
            string left;
            string right;
            string leftLong;
            string rightLong;
            string answer = "";
            ulong tempLonga;
            ulong tempLongb;
            string sign;
            bool moveOn;
            string name;
            string tempLeft;
            string tempRight;
            ulong result;
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

                    // determine if we have a sign
                    if (data[i].Split(' ').Length > 2) {
                        sign = data[i].Split(':')[1].Split(' ')[2];
                    }
                    else {sign = "";}
                    //if there's a sign, we will work with the 2 values
                    if (sign != "") {
                        //the main name we're at is assigned, then the left and right values
                        name = data[i].Split(':')[0];
                        left = data[i].Split(':')[1].Split(' ')[1];
                        right =data[i].Split(':')[1].Split(' ').Last();
                        moveOn = true;
                        tempLonga = 0;
                        tempLongb = 0;
                        //try to parse left and right values, if they are numbers, we calculate them
                        leftCheck = ulong.TryParse(left, out tempLonga);
                        rightCheck = ulong.TryParse(right, out tempLongb);
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
                                    if ( ulong.TryParse(tempLeft.Split(' ')[1], out result) ) {
                                        leftLong = result.ToString();
                                    }
                                }
                            } else {leftLong = tempLonga.ToString();}
                            if (tempLongb == 0) {
                                tempRight = "^" + right + ":";
                                tempRight = data.Find(s => Regex.IsMatch(s, tempRight))!;

                                if (tempRight.Split(' ').Length == 2) {
                                    if ( ulong.TryParse(tempRight.Split(' ')[1], out result) ) {
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
            ulong humanMax = 10000000000000;
            ulong humanMin = 0;
            bool restart;
            ulong testValue = 0;
            while( ! data.Exists(s => Regex.IsMatch(s, pattern)))
            {
                //     Console.WriteLine();
                // foreach (string line in data) {
                //     Console.WriteLine(line);
                // }
                if (dataOld.SequenceEqual(data) && !dataminimized) {dataminimized = true;}
                
                if (data.Count(x => x.Contains("humn")) == 2 && !dataminimized) {
                    dataOld = new List<string>(data);
                }
                restart = false;
                // increment count 
                count++;
                //initialize VARIABLES
                left = "";
                right = "";
                leftLong = "blank";
                rightLong = "blank";
                //start loop to go through each value in the list of work
                testValue = ((humanMax + humanMin) / 2);
                if (dataminimized) {
//                    Console.WriteLine(testValue + " " + humanMin + " " + humanMax);
                    int index = data.FindIndex(s => s.Contains("humn: "));
                    data[index] = "humn: " + testValue.ToString();
                }
                for (int i=0; i < data.Count; i++) {
                    //reset values for left and right
                    left = "";
                    right = "";                    
                    leftLong = "blank";
                    rightLong = "blank";
                    if (!dataminimized) {
                        if (data[i].Contains("humn")) {continue;}
                    }
                    // determine if we have a sign
                    if (data[i].Split(' ').Length > 2) {
                        sign = data[i].Split(':')[1].Split(' ')[2];
                    }
                    else {sign = "";}
                    //if there's a sign, we will work with the 2 values
                    if (sign != "") {
                        //the main name we're at is assigned, then the left and right values
                        name = data[i].Split(':')[0];
                        left = data[i].Split(':')[1].Split(' ')[1];
                        right =data[i].Split(':')[1].Split(' ').Last();
                        moveOn = true;
                        tempLonga = 0;
                        tempLongb = 0;
                        //try to parse left and right values, if they are numbers, we calculate them
                        
                        leftCheck = ulong.TryParse(left, out tempLonga);
                        rightCheck = ulong.TryParse(right, out tempLongb);
                        if (leftCheck && rightCheck && name != "root") {
                            tempCharA = sign.ToCharArray()[0];
                            
                            answer = calculateValue(tempLonga, tempLongb, tempCharA).ToString();
                            moveOn = false;
                        }
                        if (moveOn) {
                            if (tempLonga == 0) {
                                tempLeft = "^" + left + ":";
                                tempLeft = data.Find(s => Regex.IsMatch(s, tempLeft))!;
                                if (tempLeft.Split(' ').Length == 2) {
                                    if ( ulong.TryParse(tempLeft.Split(' ')[1], out result) ) {
                                        leftLong = result.ToString();
                                    }
                                }
                            } else {leftLong = tempLonga.ToString();}
                            if (tempLongb == 0) {
                                tempRight = "^" + right + ":";
                                tempRight = data.Find(s => Regex.IsMatch(s, tempRight))!;

                                if (tempRight.Split(' ').Length == 2) {
                                    if ( ulong.TryParse(tempRight.Split(' ')[1], out result) ) {
                                        rightLong = result.ToString();
                                    }
                                }
                            } else {rightLong = tempLongb.ToString();}
                            if (leftLong != "blank" && rightLong != "blank") {
                                if (name == "root" && calculateValue(ulong.Parse(leftLong), ulong.Parse(rightLong), '=') == 0) {
                                    answer = testValue.ToString();
                                }
                                else if (name == "root" && calculateValue(ulong.Parse(leftLong), ulong.Parse(rightLong), '=') == 1) {
                                    humanMax = testValue;
                                    data = new List<string>(dataOld);
                                    restart = true;
                                }
                                else if (name == "root" && calculateValue(ulong.Parse(leftLong), ulong.Parse(rightLong), '=') == 2) {
                                    humanMin = testValue;
                                    data = new List<string>(dataOld);
                                    restart = true;
                                }

                                else {
                                    answer = leftLong + " " + sign  + " " + rightLong;
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
                        if (restart) {continue;}
                        data[i] = name + ": " + answer;
                    }


                }
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