### Initial Setup
$data = cat C:\Tools\advent2022\challenge18.txt
<#
$data = @("2,2,2"
"1,2,2"
"3,2,2"
"2,1,2"
"2,3,2"
"2,2,1"
"2,2,3"
"2,2,4"
"2,2,6"
"1,2,5"
"3,2,5"
"2,1,5"
"2,3,5")
#>
$surfaceArea = $data.Length * 6


$gridOffsets = @(
"-1,0,0"
"1,0,0"
"0,-1,0"
"0,1,0"
"0,0,-1"
"0,0,1"
)
$airPockets = @()
foreach ($a in 0..20) {
    foreach ($b in 0..20) {
        foreach ($c in 0..20) {
            if ("$a,$b,$c" -notin $data) {
                $airPockets += "$a,$b,$c"
            }
        }
    }
}


### Find answer to problem one, just calculate surface area and remove adjacent air surfaces
foreach ($offset in $gridOffsets) {
    $points = $offset.split(',')
    $ox = [int]$points[0]
    $oy = [int]$points[1]
    $oz = [int]$points[2]

    foreach ($line in $data) {
        [int]$x,[int]$y,[int]$z = $line.split(',')

        $checkPoint = "$($ox+$x),$($oy+$y),$($oz+$z)"
        if ($data -contains $checkPoint) {
            $surfaceArea -= 1            
        }
    }
}
"Part 1 Answer = $surfaceArea"
$airPockets = $airPockets | select -Unique


###Now go and find anything that is surrounded on all 6 sides and name it an inside pocket otherwise name it outside

$insidePockets = @()
$outsidePockets = @()
foreach ($pocket in $airPockets) {
    [int]$x,[int]$y,[int]$z = $pocket.split(',')

    $posX=$true
    $negX=$true
    $posY=$true
    $negY=$true
    $posZ=$true
    $negZ=$true

    $all6sidesfound = $false
    foreach ($check in 1..20) {
        if (($x + $check -gt 20 -and $posx) -or ($y + $check -gt 20 -and $posy) -or ($z + $check -gt 20 -and $posZ) -or ($x - $check -lt 0 -and $negX) -or ($y - $check -lt 0 -and $negY) -or ($z - $check -lt 0 -and $negZ)) {break}
        if ("$($x+$check),$y,$z" -in $data) {
            $posX = $false
        }
        if ("$($x-$check),$y,$z" -in $data) {
            $negX = $false
        }
        if ("$x,$($y+$check),$z" -in $data) {
            $posY = $false
        }
        if ("$x,$($y-$check),$z" -in $data) {
            $negY = $false
        }
        if ("$x,$y,$($z+$check)" -in $data) {
            $posZ = $false
        }
        if ("$x,$y,$($z-$check)" -in $data) {
            $negZ = $false
        }
        if (!$posX -and !$negX -and !$posY -and !$negY -and !$posZ -and !$negZ) {
            $all6sidesfound = $true
            break
        }
    }
    if ($all6sidesfound) {
        $insidePockets += $pocket
    } else {
        
        $outsidePockets += $pocket
    }

}

#

$insidePockets = $insidePockets | select -Unique
$outsidePockets = $outsidePockets | select -Unique
#
$insideCount = $insidePockets.Count + 1
while ($insidePockets.count -ne $insideCount) {
    $insideCount = $insidePockets.Count
    $temppockets = @()
    foreach ($offset in $gridOffsets) {
        $points = $offset.split(',')
        $ox = [int]$points[0]
        $oy = [int]$points[1]
        $oz = [int]$points[2]

        foreach ($line in $outsidePockets) {
            [int]$x,[int]$y,[int]$z = $line.split(',')


            $checkPoint = "$($ox+$x),$($oy+$y),$($oz+$z)"
            if ($insidePockets -contains $checkPoint) {
                $temppockets += $checkPoint
            }
        }
    }
    foreach ($pocket in $temppockets) {
        $insidePockets = $insidePockets | where {$_ -ne $pocket}
        $outsidePockets += $pocket
    }
}

$airSurfaceArea = $insidePockets.count * 6
foreach ($offset in $gridOffsets) {
    $points = $offset.split(',')
    $ox = [int]$points[0]
    $oy = [int]$points[1]
    $oz = [int]$points[2]

    foreach ($line in $insidePockets) {
        [int]$x,[int]$y,[int]$z = $line.split(',')

        $checkPoint = "$($ox+$x),$($oy+$y),$($oz+$z)"
        if ($insidePockets -contains $checkPoint) {
            $airSurfaceArea -= 1
        }
    }
}
"Part 2 Answer = $($surfaceArea - $airSurfaceArea)"


<#Run the code below to visualize what is and isn't working
foreach ($size in 0..20) {
    $grid = foreach ($fake in 0..20) {
            ,('.','.','.','.','.','.','.','.','.','.','.','.','.','.','.','.','.','.','.','.')
        }
    
    foreach ($a in $data -match ','+$size + '$') {
        $y = $a.split(',')[0]
        $z = $a.split(',')[1]
        $grid[$y][$z] = "#"
    }
    foreach ($a in $outsidepockets -match ','+$size + '$') {
        $y = $a.split(',')[0]
        $z = $a.split(',')[1]
        $grid[$y][$z] = "X"
    }
0..20 | foreach {$grid[$_] -join ''}
""
sleep 1
}
#>
