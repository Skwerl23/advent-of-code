$data = Get-Content C:\Tools\advent2022\challenge10.txt

$x = 1
$count= 1
$strength = 0
$row = 0
$text= 1..6 | % { ,(".",".",".",".",".",".",".",".",".",".",".",".",".",".",".",".",".",".",".",".",".",".",".",".",".",".",".",".",".",".",".",".",".",".",".",".",".",".",".",".") }

foreach ($line in $data) {
        $a = $line.split(' ')[0]
        $b = $line.split(' ')[1]
    $cycles = 0
    if ($line -match "noop") {
        $cycles+=1
        $next = 1
    }
    else {
        $cycles+=2
        $next = 2
    }
    foreach ($cycle in 1..$cycles) {
        $next -= 1
        if ($count % 40 -eq 0) {
            $row += 1
            $row = $row %6
        }
        if ([math]::Abs($x-(($count-1)%40)) -le 1) {
            $text[$row][$count%40] = "#"
        }

        if (($count+20) % 40 -eq 0) {
                $strength += $count*$x
        }
        if ($next -eq 0) {
            $x+= [int]$b
            $b = 0
        }
        $count++
    }
}
"Answer 1:"
$strength
"Answer 2:"
0..5 | % {($text[$_] -join '')}
