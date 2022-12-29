$data = cat 'C:\Tools\advent2022\Challenge23.txt'
<#
$data = @(
"....#.."
"..###.#"
"#...#.#"
".#...##"
"#.###.."
"##.#.##"
".#..#.."
)
#>

#build initial grids
$gridLeft = $data | % {,([char[]]$_)}
$gridRight = $gridLeft | % {$a = $_ | % {"0"}; ,($a)}

#create function to propose moves
function move-check ($i, $j, $round) {
    #gather a 3x3 grid around the current location i am checking
    if ($i -lt $gridLeft.Length-1 -and $j -lt $gridLeft[0].Length-1 -and $i -gt 0 -and $j -gt 0) {
        $Smallgrid = @(($script:gridLeft[$i-1][$j-1],$script:gridLeft[$i-1][$j],$script:gridLeft[$i-1][$j+1]) ,($script:gridLeft[$i][$j-1],$script:gridLeft[$i][$j],$script:gridLeft[$i][$j+1]) ,($script:gridLeft[$i+1][$j-1],$script:gridLeft[$i+1][$j],$script:gridLeft[$i+1][$j+1]))
    }
    #verified
    elseif ($i -eq 0 -and $j -eq 0) {
        $Smallgrid = @((".",".",".") ,(".",$script:gridLeft[$i][$j],$script:gridLeft[$i][$j+1]) ,(".",$script:gridLeft[$i+1][$j],$script:gridLeft[$i+1][$j+1]))
    }
    elseif ($i -eq 0) {
        $Smallgrid = @((".",".",".") ,($script:gridLeft[$i][$j-1],$script:gridLeft[$i][$j],$script:gridLeft[$i][$j+1]) ,($script:gridLeft[$i+1][$j-1],$script:gridLeft[$i+1][$j],$script:gridLeft[$i+1][$j+1]))
    }
    elseif ($j -eq 0) {
        $Smallgrid = @((".",$script:gridLeft[$i-1][$j],$script:gridLeft[$i-1][$j+1]) ,(".",$script:gridLeft[$i][$j],$script:gridLeft[$i][$j+1]) ,(".",$script:gridLeft[$i+1][$j],$script:gridLeft[$i+1][$j+1]))
    }
    elseif ($i -eq $gridLeft.Length-1 -and $j -eq $gridLeft[0].Length-1) {
        $Smallgrid = @(($script:gridLeft[$i-1][$j-1],$script:gridLeft[$i-1][$j],".") ,($script:gridLeft[$i][$j-1],$script:gridLeft[$i][$j],".") ,(".",".","."))
    }
    elseif ($i -eq $gridLeft.Length-1 ) {
        $Smallgrid = @(($script:gridLeft[$i-1][$j-1],$script:gridLeft[$i-1][$j],$script:gridLeft[$i-1][$j+1]) ,($script:gridLeft[$i][$j-1],$script:gridLeft[$i][$j],$script:gridLeft[$i][$j+1]) ,(".",".","."))
    }
    elseif ($j -eq $gridLeft[0].Length-1) {
        $Smallgrid = @(($script:gridLeft[$i-1][$j-1],$script:gridLeft[$i-1][$j],".") ,($script:gridLeft[$i][$j-1],$script:gridLeft[$i][$j],".") ,($script:gridLeft[$i+1][$j-1],$script:gridLeft[$i+1][$j],"."))
    }

    # If my current grid is all empty spaces, i don't move
   if ($smallgrid[0][0] -eq "." -and $smallgrid[0][1] -eq "." -and $smallgrid[0][2] -eq "." -and $smallgrid[1][0] -eq "." -and $smallgrid[1][2] -eq "." -and $smallgrid[2][0] -eq "." -and $smallgrid[2][1] -eq "." -and $smallgrid[2][2] -eq ".") {$script:gridRight[$i+1][$j+1] = "#"}

    ### Check if each direction is available depending on the current round number. if so, add 1 to the proposed location. if no spots available, set self as elf
   else {
        #up
        if ($round -in @(1) -and $Smallgrid[0][0] -ne "#" -and $Smallgrid[0][1] -ne "#" -and $Smallgrid[0][2] -ne "#") {
            $script:gridRight[$i][$j+1] = [string]([int]$script:gridRight[$i][$j+1] + 1)

        }
        #down
        elseif ($round -in @(1,2) -and $Smallgrid[2][0] -ne "#" -and $Smallgrid[2][1] -ne "#" -and $Smallgrid[2][2] -ne "#") {
            $script:gridRight[$i+2][$j+1] = [string]([int]$script:gridRight[$i+2][$j+1] + 1)
        }
        #left
        elseif ($round -in @(1,2,3) -and $Smallgrid[0][0] -ne "#" -and $Smallgrid[1][0] -ne "#" -and $Smallgrid[2][0] -ne "#") {
            $script:gridRight[$i+1][$j] = [string]([int]$script:gridRight[$i+1][$j]+ 1)
        }
        #right
        elseif ($round -in @(1,2,3,0) -and $Smallgrid[0][2] -ne "#" -and $Smallgrid[1][2] -ne "#" -and $Smallgrid[2][2] -ne "#") {
            $script:gridRight[$i+1][$j+2] = [string]([int]$script:gridRight[$i+1][$j+2] + 1)
        }
        #up
        elseif ($round -in @(2,3,0) -and $Smallgrid[0][0] -ne "#" -and $Smallgrid[0][1] -ne "#" -and $Smallgrid[0][2] -ne "#") {
            $script:gridRight[$i][$j+1] = [string]([int]$script:gridRight[$i][$j+1] + 1)
        }
        #down
        elseif ($round -in @(3,0) -and $Smallgrid[2][0] -ne "#" -and $Smallgrid[2][1] -ne "#" -and $Smallgrid[2][2] -ne "#") {
            $script:gridRight[$i+2][$j+1] = [string]([int]$script:gridRight[$i+2][$j+1] + 1)
        }
        #left
        elseif ($round -in @(0) -and $Smallgrid[0][0] -ne "#" -and $Smallgrid[1][0] -ne "#" -and $Smallgrid[2][0] -ne "#") {
            $script:gridRight[$i+1][$j] = [string]([int]$script:gridRight[$i+1][$j]+ 1)
        }
        else {$script:gridRight[$i+1][$j+1] = "#"}
    }
}

#create function to perform actual move updates
function move-do ($i, $j, $round) {

        #if the move is available make it this is dependent on round number aswell
        if ($script:gridRight[$i][$j+1] -eq 1 -and $round -in @(1)) {$script:gridRight[$i][$j+1] = "#"}
        #if the move is "available" but proposed by more than one elf, i can't move so set self as elf
        elseif ($script:gridRight[$i][$j+1] -gt 1 -and $round -in @(1)) {$script:gridRight[$i+1][$j+1] = "#"}

        #repeat above logic based on round and open moves
        elseif ($script:gridRight[$i+2][$j+1] -eq 1 -and $round -in @(1,2)) {$script:gridRight[$i+2][$j+1] = "#"}
        elseif ($script:gridRight[$i+2][$j+1] -gt 1 -and $round -in @(1,2)) {$script:gridRight[$i+1][$j+1] = "#"}

        elseif ($script:gridRight[$i+1][$j] -eq 1 -and $round -in @(1,2,3)) {$script:gridRight[$i+1][$j] = "#"}
        elseif ($script:gridRight[$i+1][$j] -gt 1 -and $round -in @(1,2,3)) {$script:gridRight[$i+1][$j+1] = "#"}

        elseif ($script:gridRight[$i+1][$j+2] -eq 1 -and $round -in @(1,2,3,0)) {$script:gridRight[$i+1][$j+2] = "#"}
        elseif ($script:gridRight[$i+1][$j+2] -gt 1 -and $round -in @(1,2,3,0)) {$script:gridRight[$i+1][$j+1] = "#"}

        elseif ($script:gridRight[$i][$j+1] -eq 1 -and $round -in @(2,3,0)) {$script:gridRight[$i][$j+1] = "#"}
        elseif ($script:gridRight[$i][$j+1] -gt 1 -and $round -in @(2,3,0)) {$script:gridRight[$i+1][$j+1] = "#"}

        elseif ($script:gridRight[$i+2][$j+1] -eq 1 -and $round -in @(3,0)) {$script:gridRight[$i+2][$j+1] = "#"}
        elseif ($script:gridRight[$i+2][$j+1] -gt 1 -and $round -in @(3,0)) {$script:gridRight[$i+1][$j+1] = "#"}

        elseif ($script:gridRight[$i+1][$j] -eq 1 -and $round -in @(0)) {$script:gridRight[$i+1][$j] = "#"}
        elseif ($script:gridRight[$i+1][$j] -gt 1 -and $round -in @(0)) {$script:gridRight[$i+1][$j+1] = "#"}

        else {$script:gridRight[$i+1][$j+1] = "#"}
}

#initialize round number
$round = 0
#loop that checks if the final changes are different, if not, we aren't moving and are done.
while ((($gridLeft | % {$_ -join ''} ) -join '') -ne (($gridright | % {$_ -join ''} ) -join '')) {
    $round++
    #copy gridright once it exists
    if ($round -ne 1) {
        $gridleft = $gridRight.Clone()
    }
    #determine how big to make right grid adn make it
    $runs = $gridLeft.Length + 1
    $gridRight = 0..$runs | % {,([string[]](0..($gridRight[0].Length + 1) | % {"0"}))}

    #get dimensions of initial left grid, so we can iterate through it.
    $width = $gridLeft[0].Length
    $height = $gridLeft.Length

    #check for elves, every elf check for available moves and propose them
    $RoundMod = $round % 4
    for ($i = 0; $i -lt $height; $i++) {
        for ($j = 0; $j -lt $width; $j++) {
            if ($gridLeft[$i][$j] -eq '#' ) {
                move-check $i $j $RoundMod
            }
        }
    }
    # repeat same loop above, but actually move
    for ($i = 0; $i -lt $height; $i++) {
        for ($j = 0; $j -lt $width; $j++) {
            if ($gridLeft[$i][$j] -eq '#' -and $gridRight[$i+1][$j+1] -ne '#' ) {
                move-do $i $j $RoundMod
            }
        }
    }
    #reset gridright with all empty spaces again. for comparison and shrinking
    $gridRight = $gridRight -replace '0', '.' -replace '1', '#' -replace '2', '.' -replace '3', '.' -replace '4', '.'
    for ($i =0; $i -lt $gridRight.Length; $i++) {
        $gridRight[$i] = $gridRight[$i].split()
    }


    #this part just removes any blank lines on each side of grid right to minimize it's footprint. probably the most taxing part of this script
    $width = $gridRight[0].Length
    $fixtop = $true
    $fixbottom = $true
    $fixLeft = $true
    $fixRight = $true
    #check if bottom line is blank and remove if necessary, repeat logic for all sides
    while ($fixbottom) {
        $height = $gridRight.Length
        if ($gridRight[-1] -match "#") {$fixbottom = $false}
        else {$gridRight = $gridRight[0..($height-2)]}
    }
    while ($fixtop) {
        $height = $gridRight.Length-1
        if ($gridRight[0] -match "#") {$fixtop = $false}
        else {$gridRight = $gridRight[1..$height]}
    }


    while ($fixLeft) {
        if (($gridRight[0..$gridRight.Length] | % {$_[0]}) -match "#") {$fixLeft = $false}
        $width = $gridRight[0].Length
        if ($fixLeft) {
            for ($i = 0; $i -lt $gridRight.Length; $i++) {
                $gridRight[$i] = $gridRight[$i][1..($width-1)]
            }
        }
    }
    while ($fixRight) {
        if (($gridRight[0..$gridRight.Length] | % {$_[-1]}) -match "#") {$fixRight = $false}
        $width = $gridRight[0].Length
        if ($fixRight) {
            for ($i = 0; $i -lt $gridRight.Length; $i++) {
                $gridRight[$i] = $gridRight[$i][0..($width-2)]
            }
        }
    }
    $answer1 = $false
    if ($round -eq 10) {$answer1 = $true}

    if ($answer1) {
        $count = $gridRight -split '' -eq "." | measure | select -expand count
        write-host "Answer for part 1 is $count"
    }
    Write-Progress -PercentComplete 1 -Activity "Unknown quantity done, but just finished round $round"
}
"Answer for Part 2 is $round"
