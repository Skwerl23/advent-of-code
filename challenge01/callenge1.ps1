$calories = cat C:\tools\advent2022\challenge1.txt
$calores = $calories + ""
$sum = 0
$maxsum = 0
$elf =0

foreach ($calorie in $calories) {
    $elf++
    if ($calorie -eq '') {
        $maxsum = [math]::max($sum,$maxsum)
        $sum = 0
    }
    else {
        $sum += $calorie
    }
}

$maxsum