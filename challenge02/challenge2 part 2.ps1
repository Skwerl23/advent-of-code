$games = cat C:\Tools\advent2022\challenge2.txt
$score = 0
$count = 0
$total = [math]::round($games.count/3)
foreach ($round in (0..($total))) {
    $count++
    foreach ($game in $games[($round*3)..(($round*3)+2)]) {
        $computer = $game.split()[0]
        $player = $game.split()[1]
        if ($player -eq "x") {
            $score += 0
            if ($computer -eq "A") {
                $score += 3
            }
            if ($computer -eq "B") {
                $score += 1
            }
            if ($computer -eq "C") {
                $score += 2
            }
        }
        if ($player -eq "y") {
            $score += 3
            if ($computer -eq "A") {
                $score += 1
            }
            if ($computer -eq "B") {
                $score += 2
            }
            if ($computer -eq "C") {
                $score += 3
            }
        }
        if ($player -eq "z") {
            $score += 6
            if ($computer -eq "A") {
                $score += 2
            }
            if ($computer -eq "B") {
                $score += 3
            }
            if ($computer -eq "C") {
                $score += 1
            }
        }
    }
    $count=0
}
$score