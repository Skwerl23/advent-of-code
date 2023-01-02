$timetaken = measure-command {
    $calories = cat C:\tools\advent2022\challenge1.txt
    $calores = $calories + ""
    $sum = 0
    $maxsum = 0

    foreach ($calorie in $calories) {
        if ($calorie -eq '') {
            $maxsum = [math]::max($sum,$maxsum)
            $sum = 0
        }
        else {
            $sum += $calorie
        }
    }

    write-host $maxsum
} | select -ExpandProperty totalmilliseconds
"Total Time was $timetaken milliseconds"