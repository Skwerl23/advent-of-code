### This answers both, challenge 1 and 2, as well as give the runtime in MilliSeconds
# took 60ms to run
Measure-Command {
$calories = cat C:\tools\advent2022\challenge1.txt
$calores = $calories + ""
$sum = 0
$maxsum = 0
$elves = @()
foreach ($calorie in $calories) {
    if ($calorie -eq "") {
        $elves += $sum
        $maxsum = [math]::max($sum,$maxsum)
        $sum = 0
    }
    else {
        [int]$sum += [int]$calorie
    }
}
$sum = 0
foreach ($a in ($elves | sort | select -last 3)) {
    $sum += $a
}
write-host "Answer 1 = $maxsum"
write-host "Answer 2 = $sum"

} | select @{N="Elapsed Time in Milliseconds"; E={$_.TotalMilliseconds}}