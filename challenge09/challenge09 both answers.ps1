$inputFile = "~\downloads\input9.txt"
$moves = Get-Content $inputFile



$posX = 0
$posY = 0
$tails = 0..8 | % { ,(0,0) }



$history1 = @{}
$history9 = @{}



foreach ($move in $moves) {
    $direction = $move.split(' ')[0]
    $distance = [int]$move.split(' ')[1]
    $steps = 0
    while ($steps -lt $distance) {
        
        if ($direction -eq "U") {$posY += 1}
        if ($direction -eq "D") {$posY -= 1}
        if ($direction -eq "L") {$posX -= 1}
        if ($direction -eq "R") {$posX += 1}
            if (($tails[0][0] - $posX) -eq 2) {$tails[0][0] -= 1; $tails[0][1] += [math]::Sign($posY - $tails[0][1])}
        elseif (($posX - $tails[0][0]) -eq 2) {$tails[0][0] += 1; $tails[0][1] += [math]::Sign($posY - $tails[0][1])}
        elseif (($tails[0][1] - $posY) -eq 2) {$tails[0][1] -= 1; $tails[0][0] += [math]::Sign($posX - $tails[0][0])}
        elseif (($posY - $tails[0][1]) -eq 2) {$tails[0][1] += 1; $tails[0][0] += [math]::Sign($posX - $tails[0][0])}
        foreach ($tail in 1..8) {
                if (($tails[$tail][0] - $tails[$tail-1][0]) -eq 2) {$tails[$tail][0] -=1;$tails[$tail][1] += [math]::Sign($tails[$tail-1][1] - $tails[$tail][1])}
            elseif (($tails[$tail-1][0] - $tails[$tail][0]) -eq 2) {$tails[$tail][0] +=1;$tails[$tail][1] += [math]::Sign($tails[$tail-1][1] - $tails[$tail][1])}
            elseif (($tails[$tail][1] - $tails[$tail-1][1]) -eq 2) {$tails[$tail][1] -=1;$tails[$tail][0] += [math]::Sign($tails[$tail-1][0] - $tails[$tail][0])}
            elseif (($tails[$tail-1][1] - $tails[$tail][1]) -eq 2) {$tails[$tail][1] +=1;$tails[$tail][0] += [math]::Sign($tails[$tail-1][0] - $tails[$tail][0])}
        }
        $steps+=1



       $history1[[string]($tails[0])] = $true
        $history9[[string]($tails[8])] = $true
        }



}
"Part1: " + $history1.count
"Part2: " + $history9.Count