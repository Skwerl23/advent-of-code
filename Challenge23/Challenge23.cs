using System;
using System.IO;
using System.Diagnostics;

namespace Year22
{
    public class Day23 {

        // Declare global variables
        public static char[,] gridLeft = new char[0,0];
        public static char[,] gridRight = new char[0,0];



        private static void moveCheck (int i, int j, int round, ref char[,] gridRight, ref char[,] gridLeft) {
            //gather a 3x3 grid around the current location i am checking
            // Console.WriteLine(gridRight.GetLength(0));
            // Console.WriteLine(i +" "+j);
            char[,] smallGrid = new char[3,3];

            for (int row = 0; row < 3; row++)
            {
                for (int col = 0; col < 3; col++)
                {
                    int y = i + row - 1;
                    int x = j + col - 1;

                    if (y >= 0 && y < gridLeft.GetLength(0) && x >= 0 && x < gridLeft.GetLength(1))
                    {
                        smallGrid[row, col] = gridLeft[y, x];
                    }
                    else
                    {
                        smallGrid[row, col] = '.';
                    }
                }
            }            //  If my current grid is all empty spaces, i don't move
           if (smallGrid[0,0] == '.' && smallGrid[0,1] == '.' && smallGrid[0,2] == '.' && smallGrid[1,0] == '.' && smallGrid[1,2] == '.' && smallGrid[2,0] == '.' && smallGrid[2,1] == '.' && smallGrid[2,2] == '.') {gridRight[i+1,j+1] = '#';}

            //  Check if each direction is available depending on the current round number. if so, add 1 to the proposed location. if no spots available, set self as elf
           else {
                //up
                if ((round == 1) && smallGrid[0,0] != '#' && smallGrid[0,1] != '#' && smallGrid[0,2] != '#') {
                    gridRight[i,j+1] = (char)(gridRight[i,j+1] + 1);
                }
                //down
                else if ((round == 1 || round == 2 ) && smallGrid[2,0] != '#' && smallGrid[2,1] != '#' && smallGrid[2,2] != '#') {
                    gridRight[i+2,j+1] = (char)(gridRight[i+2,j+1] + 1);
                }
                //left
                else if ((round == 1 || round == 2 || round == 3) && smallGrid[0,0] != '#' && smallGrid[1,0] != '#' && smallGrid[2,0] != '#') {
                    gridRight[i+1,j] = (char)(gridRight[i+1,j] + 1);
                }
                //right
                else if ((round == 1 || round == 2 || round == 3 || round == 0) && smallGrid[0,2] != '#' && smallGrid[1,2] != '#' && smallGrid[2,2] != '#') {
                    gridRight[i+1,j+2] = (char)(gridRight[i+1,j+2] + 1);
                }
                //up
                else if ((round == 2 || round == 3 || round == 0) && smallGrid[0,0] != '#' && smallGrid[0,1] != '#' && smallGrid[0,2] != '#') {
                    gridRight[i,j+1] = (char)(gridRight[i,j+1] + 1);
                }
                //down
                else if ((round == 3 || round == 0) && smallGrid[2,0] != '#' && smallGrid[2,1] != '#' && smallGrid[2,2] != '#') {
                    gridRight[i+2,j+1] = (char)(gridRight[i+2,j+1] + 1);
                }
                //left
                else if ((round == 0) && smallGrid[0,0] != '#' && smallGrid[1,0] != '#' && smallGrid[2,0] != '#') {
                    gridRight[i+1,j] = (char)(gridRight[i+1,j] + 1);
                }
                else {gridRight[i+1,j+1] = '#';}
            }
        }

        //create function to perform actual move updates
        private static void moveDo (int i, int j, int round, ref char[,] gridRight) {

                //if the move is available make it this is dependent on round number aswell
                if (gridRight[i,j+1] == '1' && round == 1 ) {gridRight[i,j+1] = '#';}
                //if the move is "available" but proposed by more than one elf, i can't move so set self as elf
                else if (gridRight[i,j+1] > '1' && round == 1 ) {gridRight[i+1,j+1] = '#';}

                //repeat above logic based on round and open moves
                else if (gridRight[i+2,j+1] == '1' && (round == 1 || round == 2)) {gridRight[i+2,j+1] = '#';}
                else if (gridRight[i+2,j+1] > '1' && (round == 1 || round == 2)) {gridRight[i+1,j+1] = '#';}

                else if (gridRight[i+1,j] == '1' && (round == 1 || round == 2 || round == 3)) {gridRight[i+1,j] = '#';}
                else if (gridRight[i+1,j] > '1' && (round == 1 || round == 2 || round == 3)) {gridRight[i+1,j+1] = '#';}

                else if (gridRight[i+1,j+2] == '1' && (round == 1 || round == 2 || round == 3 || round == 0)) {gridRight[i+1,j+2] = '#';}
                else if (gridRight[i+1,j+2] > '1' && (round == 1 || round == 2 || round == 3 || round == 0)) {gridRight[i+1,j+1] = '#';}

                else if (gridRight[i,j+1] == '1' && (round == 2 || round == 3 || round == 0)) {gridRight[i,j+1] = '#';}
                else if (gridRight[i,j+1] > '1' && (round == 2 || round == 3 || round == 0)) {gridRight[i+1,j+1] = '#';}

                else if (gridRight[i+2,j+1] == '1' && (round ==3 || round == 0)) {gridRight[i+2,j+1] = '#';}
                else if (gridRight[i+2,j+1] > '1' && (round ==3 || round == 0)) {gridRight[i+1,j+1] = '#';}

                else if (gridRight[i+1,j] == '1' && round == 0) {gridRight[i+1,j] = '#';}
                else if (gridRight[i+1,j] > '1' && round == 0) {gridRight[i+1,j+1] = '#';}

                else {gridRight[i+1,j+1] = '#';}
                // Console.WriteLine(i + " " + j + " " + gridRight[i,j+1]);
        }


        public static void Run () {
Stopwatch stopwatch = new Stopwatch();
stopwatch.Start();

            //took around 18500ms to run or approx 19x faster than Powershell - i know theres a faster way,
            //something to note, some powershell functions didnt transfer 1 for 1 so this should be slower than it is.\
            // there are more loops in this, since powershell has concat options i haven't found for c# yet.



string data = File.ReadAllText(@"C:\Tools\advent2022\Challenge23.txt");

// Split the string into an array of lines
string[] lines = data.Split('\n');

// Calculate the height and width of the array
int height = lines.Length;
int width = lines[0].Length;

// Console.WriteLine(height + " " + width);
// Create the 2D character array
gridLeft = new char[height, width];

// Populate the array
for (int row = 0; row < height; row++)
{
    for (int col = 0; col < width; col++)
    {
         gridLeft[row, col] = lines[row][col];
    }
}

// gridLeft = new char[7,7] {
//   {'.', '.', '.', '.', '#', '.', '.'},
//   {'.', '.', '#', '#', '#', '.', '#'},
//   {'#', '.', '.', '.', '#', '.', '#'},
//   {'.', '#', '.', '.', '.', '#', '#'},
//   {'#', '.', '#', '#', '#', '.', '.'},
//   {'#', '#', '.', '#', '.', '#', '#'},
//   {'.', '#', '.', '.', '#', '.', '.'}};


// initialize round number
int rows=0;
int cols=0;
int round = 0;
// loop that checks if the final changes are different, if not, we aren't moving and are done.
gridRight = new char[1,1] {{'0'}};
string leftCheck = "left";
string rightCheck = "right";

//find new way to validate continuing loop
while (leftCheck != rightCheck) {
    round++;
    // Console.WriteLine(round);
    // copy gridRight once it exists
    if (round > 1) {
        gridLeft = (char[,])gridRight.Clone();
    }
    // determine how big to make right grid adn make it
    width = gridLeft.GetLength(1) + 4;
    height = gridLeft.GetLength(0) + 4;
    gridRight = new char[height, width];
    for (int i = 0; i < height; i++)
    {
        for (int j = 0; j < width; j++)
        {
            gridRight[i, j] = '0';
        }
    }
    // check for elves, every elf check for available moves and propose them
    int roundMod = round % 4;
    width = gridLeft.GetLength(1);
    height = gridLeft.GetLength(0);

    for (int i = 0; i < height; i++) {
        for (int j = 0; j < width; j++) {
            if (gridLeft[i,j] == '#' ) {
                moveCheck(i, j, roundMod, ref gridRight, ref gridLeft);
            }
        }
    }
    //  repeat same loop above, but actually move
    for (int i = 0; i < height; i++) {
        for (int j = 0; j < width; j++) {
            if (gridLeft[i,j] == '#' && gridRight[i+1,j+1] != '#' ) {
                moveDo(i, j, roundMod, ref gridRight);
            }
        }
    }
    // reset gridRight with all empty spaces again. for comparison and shrinking

    for (int i = 0; i < gridRight.GetLength(0); i++)
    {
        for (int j = 0; j < gridRight.GetLength(1); j++)
        {
            if (gridRight[i, j] == '0' || gridRight[i, j] == '2' || gridRight[i, j] == '3' || gridRight[i, j] == '4')
            {
                gridRight[i, j] = '.';
            }
            else if (gridRight[i, j] == '1')
            {
                gridRight[i, j] = '#';
            }
        }
    }
    // this part just removes any blank lines on each side of grid right to minimize it's footprint. probably the most taxing part of this script
    width = gridRight.GetLength(1);
    bool fixtop = true;
    bool fixbottom = true;
    bool fixLeft = true;
    bool fixRight = true;
    // check if bottom line is blank and remove if necessary, repeat logic for all sides
    char[,] newArray = new char[1, 1];

    while (fixbottom) {
        for (int i = 0; i < gridRight.GetLength(1); i++) {
            if (gridRight[gridRight.GetLength(0) - 1, i] == '#') {fixbottom = false; break;}
        }
 
        if (fixbottom) {
            rows = gridRight.GetLength(0);
            cols = gridRight.GetLength(1);
            newArray = new char[rows - 1, cols];

            // Copy the elements from the original array to the new array, starting from the second row
            for (int i = 0; i < rows-1; i++)
            {
                for (int j = 0; j < cols; j++)
                {
                    newArray[i, j] = gridRight[i, j];
                }
            }
            gridRight = (char[,])newArray.Clone();
        }
    }
    while (fixtop) {
        for (int i = 0; i < gridRight.GetLength(1); i++) {       
            if (gridRight[0, i] == '#') {fixtop = false; break;}
        }
 
        if (fixtop) {
            rows = gridRight.GetLength(0);
            cols = gridRight.GetLength(1);
            newArray = new char[rows - 1, cols];

            // Copy the elements from the original array to the new array, starting from the second row
            for (int i = 0; i < rows-1; i++)
            {
                for (int j = 0; j < cols; j++)
                {
                    newArray[i, j] = gridRight[i+1, j];
                }
            }
            gridRight = (char[,])newArray.Clone();
        }
    }


    while (fixLeft) {
        for (int i = 0; i < gridRight.GetLength(0); i++) {       
            if (gridRight[i, 0] == '#') {fixLeft = false; break;}
        }
 
        if (fixLeft) {
            rows = gridRight.GetLength(0);
            cols = gridRight.GetLength(1);
            newArray = new char[rows, cols-1];

            // Copy the elements from the original array to the new array, starting from the second row
            for (int i = 0; i < rows; i++)
            {
                for (int j = 0; j < cols-1; j++)
                {
                    newArray[i, j] = gridRight[i, j+1];
                }
            }
            gridRight = (char[,])newArray.Clone();
        }
    }
    while (fixRight) {
        for (int i = 0; i < gridRight.GetLength(0); i++) {       
            if (gridRight[i, gridRight.GetLength(1) - 1] == '#') {fixRight = false; break;}
        }
 
        if (fixRight) {
            rows = gridRight.GetLength(0);
            cols = gridRight.GetLength(1);
            newArray = new char[rows, cols-1];

            // Copy the elements from the original array to the new array, starting from the second row
            for (int i = 0; i < rows; i++)
            {
                for (int j = 0; j < cols-1; j++)
                {
                    newArray[i, j] = gridRight[i, j];
                }
            }
            gridRight = (char[,])newArray.Clone();
        }
    }
    bool answer1 = false;
    if (round == 10) {answer1 = true;}

    if (answer1) {
        int count = 0;
            rows = gridRight.GetLength(0);
            cols = gridRight.GetLength(1);
            for (int i = 0; i < rows; i++)
            {
                for (int j = 0; j < cols; j++)
                {
                    if (gridRight[i, j] == '.'){count++;}
                }
            }

    // for (int i = 0; i < gridRight.GetLength(0); i++)
    // {
    //     for (int j = 0; j < gridRight.GetLength(1); j++)
    //     {
    //         Console.Write(gridRight[i, j]);
    //     }
    //     Console.WriteLine();
    // }



        Console.WriteLine("Answer for part 1 is " + count);
    }

    leftCheck = "";
    rightCheck = "";
    rows = gridLeft.GetLength(0);
    cols = gridLeft.GetLength(1);
    for (int i = 0; i < rows; i++)
    {
        for (int j = 0; j < cols; j++)
        {
            leftCheck = string.Concat(leftCheck, gridLeft[i,j]);
        }
    }
    rows = gridRight.GetLength(0);
    cols = gridRight.GetLength(1);
    for (int i = 0; i < rows; i++)
    {
        for (int j = 0; j < cols; j++)
        {
            rightCheck = string.Concat(rightCheck, gridRight[i,j]);
        }
    }


}

        Console.WriteLine("Answer for part 2 is " + round);











stopwatch.Stop();
TimeSpan elapsed = stopwatch.Elapsed;
double elapsedMilliseconds = elapsed.TotalMilliseconds;
double elapsedSeconds = elapsed.TotalSeconds;

Console.WriteLine("Elapsed time: {0} milliseconds ({1} seconds)", elapsedMilliseconds, elapsedSeconds);
        }

    }

}