Measure-Command {
$games = cat C:\Tools\advent2022\challenge2.txt
$score = 0
$score2 = 0

#a = rock, b = paper, c = scissors
#x = rock, Y = paper, Z = scissors
# you chose - 1 pt for rock, 2 for paper, 3 for scissors
# outcome - 0 pts to lose, 3 to tie, 6 to win
$scoreHash = @{"A X"=4;"A Y"=8;"A Z"=3;"B X"=1;"B Y"=5;"B Z"=9;"C X"=7;"C Y"=2;"C Z"=6;}

# a = rock, b = paper, c = scissors
# x = lose, Y = tie, Z = win
# you chose - 1 pt for rock, 2 for paper, 3 for scissors
# outcome - 0 pts to lose, 3 to tie, 6 to win
$score2Hash = @{"A X"=3;"A Y"=4;"A Z"=8;"B X"=1;"B Y"=5;"B Z"=9;"C X"=2;"C Y"=6;"C Z"=7;}

foreach ($round in $games) {
    $score  += $scoreHash[$round]
    $score2 += $score2Hash[$round]
}
write-host "Answer 1 = $score"
write-host "Answer 2 = $score2"
} | select @{N="Milliseconds Run Time"; E={$_.TotalMilliseconds}}