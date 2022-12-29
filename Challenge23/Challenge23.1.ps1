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


$gridLeft = $data | % {,([char[]]$_)}
$gridRight = $gridLeft | % {$a = $_ | % {"0"}; ,($a)}

function move-check ($i, $j, $round) {
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

   if ($smallgrid[0][0] -eq "." -and $smallgrid[0][1] -eq "." -and $smallgrid[0][2] -eq "." -and $smallgrid[1][0] -eq "." -and $smallgrid[1][2] -eq "." -and $smallgrid[2][0] -eq "." -and $smallgrid[2][1] -eq "." -and $smallgrid[2][2] -eq ".") {$script:gridRight[$i+1][$j+1] = "#"}
   else {
        #up
        if ($round -in @(1) -and $Smallgrid[0][0] -ne "#" -and $Smallgrid[0][1] -ne "#" -and $Smallgrid[0][2] -ne "#") {
#            if ([int]$script:gridRight[$i][$j+1] -ge 1) {$script:gridRight[$i+1][$j+1] = "#"}
            $script:gridRight[$i][$j+1] = [string]([int]$script:gridRight[$i][$j+1] + 1)

        }
        #down
        elseif ($round -in @(1,2) -and $Smallgrid[2][0] -ne "#" -and $Smallgrid[2][1] -ne "#" -and $Smallgrid[2][2] -ne "#") {
#            if ([int]$script:gridRight[$i+2][$j+1] -ge 1) {$script:gridRight[$i+1][$j+1] = "#"}

            $script:gridRight[$i+2][$j+1] = [string]([int]$script:gridRight[$i+2][$j+1] + 1)
        }
        #left
        elseif ($round -in @(1,2,3) -and $Smallgrid[0][0] -ne "#" -and $Smallgrid[1][0] -ne "#" -and $Smallgrid[2][0] -ne "#") {
#            if ([int]$script:gridRight[$i+1][$j] -ge 1) {$script:gridRight[$i+1][$j+1] = "#"}
            $script:gridRight[$i+1][$j] = [string]([int]$script:gridRight[$i+1][$j]+ 1)
        }
        #right
        elseif ($round -in @(1,2,3,0) -and $Smallgrid[0][2] -ne "#" -and $Smallgrid[1][2] -ne "#" -and $Smallgrid[2][2] -ne "#") {
#            if ([int]$script:gridRight[$i+1][$j+2] -ge 1) {$script:gridRight[$i+1][$j+1] = "#"}
            $script:gridRight[$i+1][$j+2] = [string]([int]$script:gridRight[$i+1][$j+2] + 1)
        }
        #up
        elseif ($round -in @(2,3,0) -and $Smallgrid[0][0] -ne "#" -and $Smallgrid[0][1] -ne "#" -and $Smallgrid[0][2] -ne "#") {
#            if ([int]$script:gridRight[$i][$j+1] -ge 1) {$script:gridRight[$i+1][$j+1] = "#"}
            $script:gridRight[$i][$j+1] = [string]([int]$script:gridRight[$i][$j+1] + 1)
        }
        #down
        elseif ($round -in @(3,0) -and $Smallgrid[2][0] -ne "#" -and $Smallgrid[2][1] -ne "#" -and $Smallgrid[2][2] -ne "#") {
#            if ([int]$script:gridRight[$i+2][$j+1] -ge 1) {$script:gridRight[$i+1][$j+1] = "#"}
            $script:gridRight[$i+2][$j+1] = [string]([int]$script:gridRight[$i+2][$j+1] + 1)
        }
        #left
        elseif ($round -in @(0) -and $Smallgrid[0][0] -ne "#" -and $Smallgrid[1][0] -ne "#" -and $Smallgrid[2][0] -ne "#") {
#            if ([int]$script:gridRight[$i+1][$j] -ge 1) {$script:gridRight[$i+1][$j+1] = "#"}
            $script:gridRight[$i+1][$j] = [string]([int]$script:gridRight[$i+1][$j]+ 1)
        }
        else {$script:gridRight[$i+1][$j+1] = "#"}
    }
}


function move-do ($i, $j, $round) {
        if ($script:gridRight[$i][$j+1] -eq 1 -and $round -in @(1)) {$script:gridRight[$i][$j+1] = "#"}
        elseif ($script:gridRight[$i][$j+1] -gt 1 -and $round -in @(1)) {$script:gridRight[$i+1][$j+1] = "#"}

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

$round = 0
while ((($gridLeft | % {$_ -join ''} ) -join '') -ne (($gridright | % {$_ -join ''} ) -join '')) {
    $round++
    if ($round -ne 1) {
        $gridleft = $gridRight.Clone()
    }
    $runs = $gridLeft.Length + 1
    $gridRight = 0..$runs | % {,([string[]](0..($gridRight[0].Length + 1) | % {"0"}))}
    $width = $gridLeft[0].Length
    $height = $gridLeft.Length

    for ($i = 0; $i -lt $height; $i++) {
        for ($j = 0; $j -lt $width; $j++) {
            if ($gridLeft[$i][$j] -eq '#' ) {
                move-check $i $j ($round % 4)
            }
        }
    }
#$gridRight| % {$_ -join ''}

    for ($i = 0; $i -lt $height; $i++) {
        for ($j = 0; $j -lt $width; $j++) {
            if ($gridLeft[$i][$j] -eq '#' -and $gridRight[$i+1][$j+1] -ne '#' ) {
                move-do $i $j ($round % 4)
            }
        }
    }
#""
#$gridRight| % {$_ -join ''}

    $gridRight = $gridRight -replace '0', '.' -replace '1', '#' -replace '2', '.' -replace '3', '.' -replace '4', '.'

    for ($i =0; $i -lt $gridRight.Length; $i++) {
        $gridRight[$i] = $gridRight[$i].split()
    }
    $width = $gridRight[0].Length
    $fixtop = $true
    $fixbottom = $true
    $fixLeft = $true
    $fixRight = $true
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
        foreach ($line in $gridRight) {
            if ($line[0] -eq '#') {$fixLeft = $false; break}
        }
        $width = $gridRight[0].Length
        if ($fixLeft) {
            for ($i = 0; $i -lt $gridRight.Length; $i++) {
                $gridRight[$i] = $gridRight[$i][1..($width-1)]
            }
        }
    }
    while ($fixRight) {
        foreach ($line in $gridRight) {
            if ($line[-1] -eq '#') {$fixRight = $false; break}
        }
        $width = $gridRight[0].Length
        if ($fixRight) {
            for ($i = 0; $i -lt $gridRight.Length; $i++) {
                $gridRight[$i] = $gridRight[$i][0..($width-2)]
            }
        }
    }
if ($round -eq 10) {break}
}

"Answer Part 1 is $round"



