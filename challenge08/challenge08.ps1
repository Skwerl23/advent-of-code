$input = Get-Content "C:\Tools\advent2022\challenge8.txt"
$count=0
foreach ($i in 0..98) {
    foreach ($j in 0..98) {
        $left = $true
        $top = $true
        $right = $true
        $bottom = $true
        foreach ($a in 0..($i-1)) {
            if ($input[$a][$j] -ge $input[$i][$j]) {
                $left = $false
            }
        }
        foreach ($a in ($i+1)..98) {
            if ($input[$a][$j] -ge $input[$i][$j]) {
                $right = $false
            }
        }
        foreach ($a in 0..($j-1)) {
            if ($input[$i][$a] -ge $input[$i][$j]) {
                $top = $false
            }
        }
        foreach ($a in ($j+1)..98) {
            if ($input[$i][$a] -ge $input[$i][$j]) {
                $bottom = $false
            }
        }
        if ($j -eq 0 -or $j -eq 98 -or $i -eq 0 -or $i -eq 98) {
            $left = $true
        }
        if ($left -or $right -or $top -or $bottom) {
            $count ++
        }

    }
}
$count
