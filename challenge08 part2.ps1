$challenge8 = Get-Content "C:\Tools\advent2022\challenge8.txt"

$count=0
$max = 0
$ErrorActionPreference = "silentlycontinue"
foreach ($i in 0..98) {

    foreach ($j in 0..98) {

        $left = 1
        $top = 1
        $right = 1
        $bottom = 1
        foreach ($a in ($i-1)..0) {
            if ($challenge8[$a][$j] -ge $challenge8[$i][$j]) {
                $top = [math]::max(1,[int]$i - $a)
                break
            }
            elseif ($a -eq 0) {
                $top = [math]::max(1,[int]$i - $a)
                break
            }

        }
        foreach ($a in ($i+1)..98) {
            if ($challenge8[$a][$j] -ge $challenge8[$i][$j]) {
                $bottom = [math]::max(1,[int]$a - $i)
                break
            }
            elseif ($a -eq 98) {
                $bottom = [math]::max(1,[int]$a - $i)                
        
                break

            }

        }
        foreach ($a in ($j-1)..0) {
            if ($challenge8[$i][$a] -ge $challenge8[$i][$j]) {
                $left = [math]::max(1,[int]$j - $a)
                break
            }
            elseif ($a -eq 0) {
                $left = [math]::max(1,[int]$j - $a)
                break

            }
        }
        foreach ($a in ($j+1)..98) {
            if ($challenge8[$i][$a] -ge $challenge8[$i][$j]) {
                $right = [math]::max(1,[int]$a - $j)
                break
            }
            elseif ($a -eq 98) {
                $right = [math]::max(1,[int]$a - $j)         
                break
            }
        }
            $x = write-output $max
            $max = [math]::Max($max, $left*$right*$top*$bottom)
            if ($max -ne $x) {
                write-output "$i , $j, $($challenge8[$i][$j])"
                
                write-output "$left, $right, $top, $bottom"
                $max
            }


        
    }
   
}
$max
