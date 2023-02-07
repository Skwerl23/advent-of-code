using System;
using System.IO;
using System.Diagnostics;
using System.Collections.Generic;
using System.Linq;
using System;


namespace Year22
{
    public class Day24 {

        private static string ConvertToArrow(int value)
        {   
            //simple algorithm to determine how many arros combine, and return the total
            //this is only needed when drawing the grid
            string arrows = "";
            if (value == 0) return ".";
            if (value == 1) return "#";
            if ((value & 16) == 16) arrows += "<";
            if ((value & 8) == 8) arrows += "v";
            if ((value & 4) == 4) arrows += ">";
            if ((value & 2) == 2) arrows += "^";
            if (arrows.Length == 1) return arrows;
            else return arrows.Length.ToString();
        }


        private static void drawGrid(int[,] grid) {
            //simple algorithm to loop through grid and draw it with characters.
            for (int i = 0; i < grid.GetLength(0); i++)
            {
                for (int j = 0; j < grid.GetLength(1); j++)
                {
                    Console.Write(ConvertToArrow(grid[i, j]));
                }
                Console.WriteLine();
            }
        }

        private static int[,] drawEmptyGrid(List<string> data) {
            //simple algorithm to draw an empty grid based on initial data. only thing this draws is walls or empty ground 
            int width = data[0].Length;
            int[,] grid = new int[data.Count, width];
            for (int i = 0; i < data.Count; i++)
            {
                for (int j = 0; j < width; j++)
                {
                    //ternary operator if data point != # we get 0 otherwise 1.
                    //i'm not sure if it's faster, but the check may be quicker with zero as true, since more non-walls (#) exist
                    grid[i,j] = (data[i][j] != '#') ? 0 : 1;
                }
            }
            return grid;
        }

        private static int[,] drawZeroGrid(List<string> data) {
            //same as drawing an empty grid, except all positions are 0
            //we feed it the data variable simply for width and height.
            int width = data[0].Length;
            int[,] grid = new int[data.Count, width];
            for (int i = 0; i < data.Count; i++)
            {
                for (int j = 0; j < width; j++)
                {
                        grid[i, j] = 0;
                }
            }
            return grid;
        }

        public static void Run () {
Stopwatch stopwatch = new Stopwatch();
stopwatch.Start();

            //took around (not measured yet but approx 200ms)

            List<string> data = File.ReadAllLines(@"C:\Tools\advent2022\Challenge24.txt").ToList();
            int width = data[0].Length;
            int height = data.Count;
            int[,] grid = new int[data.Count, width];
            int[,] positions = drawZeroGrid(data);
            positions[0,1] = 1;

            //using a hashmap we can quickly draw our grid out based on the initial character of the input file
            Dictionary<char, int> gridHash = new Dictionary<char, int>() { { '.', 0 }, { '#', 1 }, { '^', 2 }, { '>', 4 }, { 'v', 8 }, { '<', 16 } };
            for (int i = 0; i < height; i++)
            {
                for (int j = 0; j < width; j++)
                {
                    grid[i,j] = gridHash[data[i][j]];
                }
            }

            //set up initial variables for loop
            int[,] gridTwo = (int[,])grid.Clone();
            int rounds = -1;
            int start = 0;
            int end=1;
            //true statement needs a break, so when we reach the end we break
            while (true) {
                rounds++;
                // Console.WriteLine("starting new grid");
                grid = (int[,])gridTwo.Clone();

                int[,] tempPositions = drawZeroGrid(data);
                //go through all positions, and see if they have any movable options
                for (int i = 0; i < height; i++)
                {
                    for (int j = 0; j < width; j++)
                    {
                        // if the positions contains a place we could be, we then calculate if it can move anywhere.
                        if (positions[i,j] == 1) {
                            //check if the grid is empty where i was last move. if so, we keep it as an option else we remove it
                            if (grid[i,j] == 0) {tempPositions[i,j] = 1;}
                            else  {tempPositions[i,j] = 0;}

                            //check if vertical neighbors are possible moves
                            //create an array of "up and down"
                            int[] vNeighbors = {i-1,i+1};
                            //loop through up and down neighbors
                            foreach (int position in vNeighbors) {
                                //check if they are inbounds
                                if (0<= position && position < height) {
                                    //check if the move is empty ground and make an option to move
                                    if (grid[position, j] == 0) {
                                        tempPositions[position,j] = 1;
                                    }
                                }
                            }
                            int[] hNeighbors = {j-1,j+1};
                            foreach (int position in hNeighbors) {
                                if (0<= position && position < width) {
                                    if (grid[i, position] == 0) {
                                        tempPositions[i,position] = 1;
                                    }
                                }
                            }
                        }
                    }
                }
                //clone changes back to positions grid
                positions = (int[,])tempPositions.Clone();
                if (positions[height-1,width-2] == 1 && start != 1) {
                    //print results for advent of code - end is used to know number of passes, and can print answer number
                    Console.WriteLine("Answer " + end + " is " + rounds);
                    //set start to 1 to prevent this from repeating
                    start = 1;
                    //if end == 2 we are at the end of all routes. kill loop
                    if (end == 2) {break;}
                    //at the end of the first run, we actually need to wipe the positions grid and set the last value to start over (go bakwards)
                    positions = drawZeroGrid(data);
                    positions[height-1,width-2] = 1;
                }
                else if (start == 1 && positions[0,1] == 1) {
                    //set values and wipe grid back to beginning, so we know the end is the last run.
                    end = 2;
                    start = 0;
                    positions = drawZeroGrid(data);
                    positions[0,1] = 1;
                }
                //wipe grid two, this way we start fresh before making it.
                gridTwo = drawEmptyGrid(data);

                //uncomment below if you want to see grids as they are made.
                // drawGrid(positions);
                // Thread.Sleep(1000);
                // drawGrid(grid);
                // Console.WriteLine();

                for (int i = 0; i < data.Count; i++)
                {
                    for (int j = 0; j < width; j++)
                    {
                        if ((grid[i,j] & 16) == 16)
                        {
                            //if statement determines if not on an edge, and moves 1 over
                            //else statement moves to other end.
                            if (j-1 != 0) {
                                gridTwo[i,j-1] += 16;
                            } else {
                                gridTwo[i,width-2] += 16;
                            }
                            grid[i,j] -= 16;
                        }
                        //repeat above logic for each direction
                        if ((grid[i,j] & 8) == 8)
                        {
                            if (i+1 != height-1) {
                                gridTwo[i+1,j] += 8;
                            } else {
                                gridTwo[1,j] += 8;
                            }
                            grid[i,j] -= 8;
                        }
                        if ((grid[i,j] & 4) == 4)
                        {
                            if (j+1 != width-1) {
                                gridTwo[i,j+1] += 4;
                            } else {
                                gridTwo[i,1] += 4;
                            }
                            grid[i,j] -= 4;
                        }
                        if ((grid[i,j] & 2) == 2)
                        {
                            if (i-1 != 0) {
                                gridTwo[i-1,j] += 2;
                            } else {
                                gridTwo[height-2,j] += 2;
                            }
                            grid[i,j] -= 2;
                        }
                    }
                }
                //close while loop
            }

stopwatch.Stop();
TimeSpan elapsed = stopwatch.Elapsed;
double elapsedMilliseconds = elapsed.TotalMilliseconds;
double elapsedSeconds = elapsed.TotalSeconds;

Console.WriteLine("Elapsed time: {0} milliseconds ({1} seconds)", elapsedMilliseconds, elapsedSeconds);
        }

    }

}