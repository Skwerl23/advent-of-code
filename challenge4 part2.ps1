$pairs = cat C:\Tools\advent2022\challenge4.txt
$count = 0
foreach ($pair in $pairs) {
    $pair1 = $pair.split(',')[0]
    $pair2 = $pair.split(',')[1]
    $low1 = [int]$pair1.split('-')[0]
    $high1 = [int]$pair1.split('-')[1]
    $low2 = [int]$pair2.split('-')[0]
    $high2 = [int]$pair2.split('-')[1]
    $range1 = @($low1..$high1)
    $range2 = @($low2..$high2)
    foreach ($i in $range1) {
        if ($i -in $range2) {
            $count+=1 
            break
        }
    }
}
$count