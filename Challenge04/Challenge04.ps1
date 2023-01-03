Measure-Command {
$ranges = cat C:\Tools\advent2022\challenge4.txt
$count1 = 0
$count2 = 0
foreach ($line in $ranges) {
    $a,$b,$c,$d = [int[]]$line.split('-,')

    $z = $false

    if (($a -le $c -and $b -ge $d) -or ($a -ge $c -and $b -le $d)) {
        $count1 +=1
    }

    foreach ($x in $a..$b) {
        foreach ($y in $c..$d) {
            $z=($x -eq $y)
            if ($z){break}
        }
        if ($z){break}
    }
    $count2 += $z
}
write-host "Answer 1 = $count1"
write-host "Answer 2 = $count2"

} | select @{N="Milliseconds Run Time"; E={$_.TotalMilliseconds}}

