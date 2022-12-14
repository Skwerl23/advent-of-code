$games = cat C:\Tools\advent2022\challenge2.txt
$score = 0
foreach ($round in $games) {
    $computer = $round.split()[0]
    $player = $round.split()[1]
    if ($computer -eq "A"){
        if ($player -eq "X") {
        $score += 1 #for rock
        $score += 3 #tie
        }
        if ($player -eq "Y") {
        $score += 2 #for paper
        $score += 6 #win
        }
        if ($player -eq "Z") {
        $score += 3 #for scissors
        $score += 0 #loss
        }
    }
    if ($computer -eq "B"){
        if ($player -eq "X") {
        $score += 1 #for rock
        $score += 0 #loss
        }
        if ($player -eq "Y") {
        $score += 2 #for paper
        $score += 3 #tie
        }
        if ($player -eq "Z") {
        $score += 3 #for scissors
        $score += 6 #win
        }
    }
    if ($computer -eq "C"){
        if ($player -eq "X") {
        $score += 1 #for rock
        $score += 6 #win
        }
        if ($player -eq "Y") {
        $score += 2 #for paper
        $score += 0 #loss
        }
        if ($player -eq "Z") {
        $score += 3 #for scissors
        $score += 3 #tie
        }
    }

}
$score