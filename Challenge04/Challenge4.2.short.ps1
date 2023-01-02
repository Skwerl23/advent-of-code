Measure-Command {
$ranges = cat C:\Tools\advent2022\challenge4.txt
$count = 0
foreach ($line in $ranges) {
    $a,$b,$c,$d = $line.split('-,')
    $z = $false
    foreach ($x in $a..$b) {
        foreach ($y in $c..$d) {
            $z=($x -eq $y)
            if ($z){break}
        }
        if ($z){break}
    }
    $count += $z
}
write-host $count
}
