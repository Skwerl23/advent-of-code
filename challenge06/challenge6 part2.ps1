$signal = cat C:\Tools\advent2022\challenge6.txt
#change gap as necessary
$gap = 14
foreach ($num in 0..$signal.Length) {
    $list = @()
    foreach ($i in 0..($gap-1)) {
    $list += $signal[$num+$i]
    }
    if (($list | select -Unique | measure | select count) -match $gap) {
        $num+$gap
        break
    }
}
