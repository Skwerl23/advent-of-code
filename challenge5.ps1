$rules = cat C:\Tools\advent2022\challenge5.txt

$stacks = $rules[0..8]
$moves = $rules[10..10000]
 
$a1=@()
$a2=@()
$a3=@()
$a4=@()
$a5=@()
$a6=@()
$a7=@()
$a8=@()
$a9=@()
foreach($x in 0..7) {
        $a1+=$stacks[$x][1]
        $a2+=$stacks[$x][5]
        $a3+=$stacks[$x][9]
        $a4+=$stacks[$x][13]
        $a5+=$stacks[$x][17]
        $a6+=$stacks[$x][21]
        $a7+=$stacks[$x][25]
        $a8+=$stacks[$x][29]
        $a9+=$stacks[$x][33]
}
$a1 = $a1[-1..-1000] | where {$_ -match '[a-zA-Z]'}
$a2 = $a2[-1..-1000] | where {$_ -match '[a-zA-Z]'}
$a3 = $a3[-1..-1000] | where {$_ -match '[a-zA-Z]'}
$a4 = $a4[-1..-1000] | where {$_ -match '[a-zA-Z]'}
$a5 = $a5[-1..-1000] | where {$_ -match '[a-zA-Z]'}
$a6 = $a6[-1..-1000] | where {$_ -match '[a-zA-Z]'}
$a7 = $a7[-1..-1000] | where {$_ -match '[a-zA-Z]'}
$a8 = $a8[-1..-1000] | where {$_ -match '[a-zA-Z]'}
$a9 = $a9[-1..-1000] | where {$_ -match '[a-zA-Z]'}


foreach ($m in $moves) {
    $m = $m.split(' ')
    $x = Get-Variable "a$($m[3])" -ValueOnly
    $y = Get-Variable "a$($m[5])" -ValueOnly
    foreach ($q in (-1..-$m[1])) {
        $y += $x[$q]
    }
    Set-Variable "a$($m[5])" -Value $y
    $x = $x[-1000..((-$m[1])-1)]
    Set-Variable "a$($m[3])" -Value $x
}


$a1[-1]
$a2[-1]
$a3[-1]
$a4[-1]
$a5[-1]
$a6[-1]
$a7[-1]
$a8[-1]
$a9[-1]
