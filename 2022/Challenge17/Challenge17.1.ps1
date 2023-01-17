$data = get-content C:\tools\advent2022\challenge17.txt


#$data = ">>><<><>><<<>><>>><<<>>><<<><<<>><>><<>>"
$erroractionpreference = "SilentlyContinue"
function get-rock($rockNumber, [int]$x, [int]$y) {
    switch ($rockNumber) {
        0 {return @( ( ($x  ) , ($y  ) ) ,( ($x+1) , ($y  ) ) ,( ($x+2) , ($y  ) ) ,( ($x+3) , ($y  ) ))}
        1 {return @( ( ($x+1) , ($y  ) ) ,( ($x  ) , ($y+1) ) ,( ($x+1) , ($y+1) ) ,( ($x+2) , ($y+1) ) ,( ($x+1) , ($y+2) ))}
        2 {return @( ( ($x+2) , ($y  ) ) ,( ($x+2) , ($y+1) ) ,( ($x  ) , ($y+2) ) ,( ($x+1) , ($y+2) ) ,( ($x+2) , ($y+2) ))}
        3 {return @( ( ($x  ) , ($y  ) ) ,( ($x  ) , ($y+1) ) ,( ($x  ) , ($y+2) ) ,( ($x  ) , ($y+3) ))}
        4 {return @( ( ($x  ) , ($y  ) ) ,( ($x+1) , ($y  ) ) ,( ($x  ) , ($y+1) ) ,( ($x+1) , ($y+1) ))}
    }

}
$stopRock = 2022


$gridBottom = 0
$gridTop = 0
$grid = @()
$y = 0
$rockNumber = 0
$startOver = $true
$starting = $true
$i = 0
$fallingRocks = 0
$count = 0
$rockHeights = @{0=1;1=3;2=3;3=4;4=2}
While ($fallingRocks -lt $stopRock) {

    Write-Progress -Activity "$fallingRocks of $stopRock" -PercentComplete ($count/$stopRock*100)
    $rock = get-rock $rockNumber $x $y
    if ($startOver) {
        for ($z = 0; $z -lt $grid.Length; $z++) {
            if ($grid[$z] -match "#") {
                break
            }
        }
        [int]$x = 2
        $grid = $grid[$z..($grid.Length-1)]
        $height = $rockHeights[$rockNumber]
        $gridBottom = $grid.Length -1 + (3 + $height)
        [int]$y = 0
    }
    while ($grid.Length -1 -ne $gridBottom) {
        $grid = ,(0..6 | % {"."}) + $grid
    }

    $startOver = $false
    
    if ($data[$i] -eq "<" ){
        $newrock = get-rock $rockNumber ($x-1) $y
    }    
    else {
        $newrock = get-rock $rockNumber ($x+1) $y
    }
    $move = $false
    foreach ($point in $newrock) {
        if ($point[0] -lt 0 -or $point[0] -gt 6 -or $point[1] -gt $gridBottom -or $grid[$point[1]][$point[0]] -eq "#") {
            $move = $false
            break
        } 
        else {$move = $true}
    }    
    if ($move) {
        if ($data[$i] -eq "<" ){
            $x -= 1
        }    
        else {
            $x += 1
        }
        $rock = get-rock $rockNumber $x $y
    }
    $newrock = get-rock $rockNumber $x ($y+1)
    $move = $false
    foreach ($point in $newrock) {
        if ($grid[$point[1]][$point[0]] -eq "#" -or $point[1] -gt $gridBottom) {
            $move = $false
            break
        } 
        else {$move = $true}
    }
    if ($move) {
        $y +=1

    }
    else {
        $y = 0
        $startover = $true

        foreach ($point in $rock) {
            $grid[$point[1]][$point[0]] = "#"
        }
        $fallingRocks += 1
        $rockNumber = ($rockNumber+1) % 5
    }
#    $grid | % {$_ -join ''}
#    ""
#    for ($z = 0; $z -lt $grid.Length; $z++) {
#        for ($b =0; $b -lt 7; $b++) {
#            if ($grid[$z][$b] -eq "@") {
#                $grid[$z][$b] = "."
#            }
#        }
#    }
#    sleep 1
    $i = ($i + 1) % $data.Length


}




for ($z = 0; $z -lt $grid.Length; $z++) {
    if ($grid[$z] -match "#") {
        break
    }
}
$grid.Length -$z