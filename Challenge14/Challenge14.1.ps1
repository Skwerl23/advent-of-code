$data = Get-Content C:\Tools\advent2022\challenge14.txt

$maxx = [int]::MinValue
$miny = [int]::MaxValue
$maxy = [int]::MinValue
$rock = [System.Collections.ArrayList]@()
foreach ($line in $data) {
    
    $current = $null
    $last = $null
    foreach ($point in $line.split(' -> ') | where {$_ -match '.'}) {
        if ($current) {
            $last = $current.clone()
        }
        $current = $point.split(',')
        if ($last) {
            foreach ($y in $last[0]..$current[0]) {
                foreach ($x in $last[1]..$current[1]) {
                    $rock.add("$x,$y") | out-null
                    $maxx = [math]::Max($x, $maxx)
                    $miny = [math]::Min($y, $miny)
                    $maxy = [math]::Max($y, $maxy)

                }

            }

        }
    
    
    }
}
$minx =0
$miny -=2
$maxx +=2
$maxy +=2
$fallx = 0
$fally = 500-$miny
$gridLine = @($miny..$maxy | % {"."})
$grid = [System.Collections.ArrayList]@()
foreach ($x in $minx..$maxx) {
    $grid.add($gridline.Clone()) | Out-Null
}   
foreach ($x in $minx..$maxx) {
    foreach ($y in $miny..$maxy) {
        if ($rock.Contains("$x,$y")) {
            $grid[$x-$minx][$y-$miny] = "#"
        }
    }
}

$run = $true
$count = 0
while ($run) {
$countold = $count
    if ($grid[$fallx][$fally] -eq '.') {
        $grid[$fallx][$fally] = "o"
    }
    for ($i=0;$i -lt (($grid.count)-1);$i++) {
        for ($j = 0; $j -lt (($grid[0].Length)-1); $j++) {
            $move = $false
            if ($grid[$i][$j] -eq "o") {
                if ($grid[$i+1][$j] -eq ".") {
                    $grid[$i+1][$j] = "o"
                $move = $true
                }
                elseif ($grid[$i+1][$j-1] -eq ".") {
                    $grid[$i+1][$j-1] = "o"

                $move = $true
                }
                elseif ($grid[$i+1][$j+1] -eq ".") {
                    $grid[$i+1][$j+1] = "o"

                $move = $true
                }
                
                if ($move) {
                    $grid[$i][$j] = "."
            
                }
            }

            if ($grid[-1] -contains "o"){$run = $false;$finalcount = $count}
        }
    }
    $count++

}
$temp = foreach ($line in $grid) {
    $line -join ''
}
clear
$temp
$finalcount
