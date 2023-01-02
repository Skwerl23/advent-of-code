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
$maxsum
$sum

}