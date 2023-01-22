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
        int width = data[0].Length;
        int[,] grid = new int[data.Count, width];
        for (int i = 0; i < data.Count; i++)
        {
            for (int j = 0; j < width; j++)
            {
                if (data[i][j] == '#')
                {
                    grid[i, j] = 1;
                }
                else {
                    grid[i, j] = 0;
                }
            }
        }
    return grid;
}
        public static void Run () {
Stopwatch stopwatch = new Stopwatch();
stopwatch.Start();

            //took around xxx 

List<string> data = File.ReadAllLines(@"C:\Tools\advent2022\Challenge24.txt").ToList();
        int width = data[0].Length;
        int height = data.Count;
        int[,] positions = new int[data.Count, width];
        int[,] grid = new int[data.Count, width];
        
        for (int i = 0; i < height; i++)
        {
            for (int j = 0; j < width; j++)
            {
                positions[i,j] = 0;
            }
        }
        positions[0,1] = 1;
        for (int i = 0; i < height; i++)
        {
            for (int j = 0; j < width; j++)
            {
                if (data[i][j] == '#')
                {
                    grid[i, j] = 1;
                }
                else if (data[i][j] == '.')
                {
                    grid[i, j] = 0;
                }
                else if (data[i][j] == '^')
                {
                    grid[i, j] = 2;
                }
                else if (data[i][j] == '>')
                {
                    grid[i, j] = 4;
                }
                else if (data[i][j] == 'v')
                {
                    grid[i, j] = 8;
                }
                else if (data[i][j] == '<')
                {
                    grid[i, j] = 16;
                }
            }
        }
        int[,] gridTwo = (int[,])grid.Clone();
    int rounds = -1;
    int start = 0;
    int end=1;
    while (true) {
        rounds++;
//        Console.WriteLine("starting new grid");
        grid = (int[,])gridTwo.Clone();

        int[,] tempPositions = (int[,])positions.Clone();
        for (int i = 0; i < height; i++)
        {
            for (int j = 0; j < width; j++)
            {
                if (positions[i,j] == 1) {
                    if (grid[i,j] == 0) {tempPositions[i,j] = 1;}
                    else  {tempPositions[i,j] = 0;}
                    int[] vNeighbors = {i-1,i+1};
                    foreach (int position in vNeighbors) {
                        if (0<= position && position < height) {
                            if (grid[position, j] == 0) {
                                tempPositions[position,j] = 1;
                            }
                            else  {tempPositions[position,j] = 0;}
                        }
                    }
                    int[] hNeighbors = {j-1,j+1};
                    foreach (int position in hNeighbors) {
                        if (0<= position && position < width) {
                            if (grid[i, position] == 0) {
                                tempPositions[i,position] = 1;
                            }
                            else  {tempPositions[i,position] = 0;}
                        }
                    }
                }
            }
        }
        positions = (int[,])tempPositions.Clone();
        if (positions[height-1,width-2] == 1 && start != 1) {
            Console.WriteLine("Answer " + end + " is " + rounds);
            start = 1;
            if (end == 2) {break;}
            for (int i = 0; i < height; i++)
            {
                for (int j = 0; j < width; j++)
                {
                    positions[i,j] = 0;
                }
            }
            positions[height-1,width-2] = 1;

        }
        if (start == 1 && positions[0,1] == 1) {
            end = 2;
            start = 0;
            for (int i = 0; i < height; i++)
            {
                for (int j = 0; j < width; j++)
                {
                    positions[i,j] = 0;
                }
            }
            positions[0,1] = 1;

        }
        gridTwo = drawEmptyGrid(data);
        // drawGrid(positions);
        // Thread.Sleep(1000);
        // drawGrid(grid);
        // Console.WriteLine();

for (int i = 0; i < data.Count; i++)
{
    for (int j = 0; j < width; j++)
    {
        while (grid[i,j] >= 2) {
            if (grid[i,j] >= 16)
            {
                if (j-1 != 0) {
                    gridTwo[i,j-1] += 16;
                } else {
                    gridTwo[i,width-2] += 16;
                }
                grid[i,j] -= 16;
            } else if (grid[i,j] >= 8)
            {
                if (i+1 != height-1) {
                    gridTwo[i+1,j] += 8;
                } else {
                    gridTwo[1,j] += 8;
                }
                grid[i,j] -= 8;
            }
            else if (grid[i,j] >= 4)
            {
                if (j+1 != width-1) {
                    gridTwo[i,j+1] += 4;
                } else {
                    gridTwo[i,1] += 4;
                }
                grid[i,j] -= 4;
            }
            else if (grid[i,j] >= 2)
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
}
//still inside while loop


    }

stopwatch.Stop();
TimeSpan elapsed = stopwatch.Elapsed;
double elapsedMilliseconds = elapsed.TotalMilliseconds;
double elapsedSeconds = elapsed.TotalSeconds;

Console.WriteLine("Elapsed time: {0} milliseconds ({1} seconds)", elapsedMilliseconds, elapsedSeconds);
        }

    }

}