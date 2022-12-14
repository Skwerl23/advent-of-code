$data = Get-Content C:\Tools\advent2022\challenge14.txt

$maxx = [int]::MinValue
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

                }

            }

        }
    
    
    }
}
$minx =0
$miny =330
$maxx +=2
$maxy =670
$fallx = 0
$fally = 500-$miny
$gridLine = @($miny..$maxy | % {"."})
$grid = [System.Collections.ArrayList]@()
$griddraw = [System.Collections.ArrayList]@()

foreach ($x in $minx..$maxx) {
    $grid.add($gridline.Clone()) | Out-Null
    $gridDraw.add($gridline.Clone()) | Out-Null
}   
foreach ($x in $minx..$maxx) {
    foreach ($y in $miny..$maxy) {
        if ($rock.Contains("$x,$y")) {
            $grid[$x-$minx][$y-$miny] = "#"
            $griddraw[$x-$minx][$y-$miny] = "#"
        }
        if ($x -eq $maxx) {
           $grid[$x-$minx][$y-$miny] = "#"
           $griddraw[$x-$minx][$y-$miny] = "#"
        }
    }
}

$run = $true
$count = 1
$waterGrid = @{}
$move = $false
while ($run) {
    
    $waterGrid["$fallx,$fally"] = $true
    foreach ($waterDrop in [string[]]($waterGrid.GetEnumerator() | where value -eq $true | select -expand key)) {
        #if (!$watergrid[$waterdrop]) {continue}
        $i = [int]$waterDrop.split(',')[0]
        $j = [int]$waterDrop.split(',')[1]

        if ($grid[$i+1][$j] -eq "." -and $waterGrid["$($i+1),$j"] -eq $null) {
            $watergrid["$($i+1),$j"]=$true
            $move = $true
        }
        elseif ($grid[$i+1][$j-1] -eq "." -and $waterGrid["$($i+1),$($j-1)"] -eq $null) {
            $watergrid["$($i+1),$($j-1)"] = $true

            $move = $true
        }
        elseif ($grid[$i+1][$j+1] -eq "." -and $waterGrid["$($i+1),$($j+1)"] -eq $null) {
            $watergrid["$($i+1),$($j+1)"] = $true

        $move = $true
        }
        elseif ($griddraw[$i+1][$j] -in @("o","#") -and $griddraw[$i+1][$j-1] -in @("o","#") -and $griddraw[$i+1][$j+1]  -in @("o","#")) {
            $waterGrid[$waterDrop]= $false
        }
        if ($move) {
#            $watergrid.remove($waterDrop) | Out-Null
            $watergrid.remove("$fallx,$fally") | Out-Null
            $move = $false
            $count++
        }
    }

    if ($countold -eq $count){"I RAN";$run = $false}
    $countold = $count


    if ($count % 1 -eq 0) {
        foreach ($item in [string[]]($waterGrid | select -expand keys)) {
            $x = $item.split(',')[0]
            $y = $item.split(',')[1]
            $gridDraw[$x][$y] = "o"

        }
        $temp = foreach ($line in $gridDraw) {
            ($line -join '') -replace '\.',' '
        }
        clear
        $temp
        $count
    }

}

foreach ($item in [string[]]($waterGrid | select -expand keys)) {
    $x = $item.split(',')[0]
    $y = $item.split(',')[1]
    $gridDraw[$x][$y] = "o"

}
$temp = foreach ($line in $gridDraw) {
    ($line -join '') -replace '\.',' '
}
clear
$temp
$count
