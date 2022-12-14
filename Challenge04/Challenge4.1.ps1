$pairs = cat C:\Tools\advent2022\challenge4.txt
$count = 0
foreach ($pair in $pairs) {
    $pair1 = $pair.split(',')[0]
    $pair2 = $pair.split(',')[1]
    $low1 = [int]$pair1.split('-')[0]
    $high1 = [int]$pair1.split('-')[1]
    $low2 = [int]$pair2.split('-')[0]
    $high2 = [int]$pair2.split('-')[1]
    if ($low1 -le $low2 -and $high1 -ge $high2) {
        $count +=1
    }
    elseif ($low1 -ge $low2 -and $high1 -le $high2) {
        $count +=1
    }
}
$count