$data = Get-Content C:\Tools\advent2022\challenge15.txt


### Test Data
<#
$data = @("Sensor at x=2, y=18: closest beacon is at x=-2, y=15"
"Sensor at x=9, y=16: closest beacon is at x=10, y=16"
"Sensor at x=13, y=2: closest beacon is at x=15, y=3"
"Sensor at x=12, y=14: closest beacon is at x=10, y=16"
"Sensor at x=10, y=20: closest beacon is at x=10, y=16"
"Sensor at x=14, y=17: closest beacon is at x=10, y=16"
"Sensor at x=8, y=7: closest beacon is at x=2, y=10"
"Sensor at x=2, y=0: closest beacon is at x=2, y=10"
"Sensor at x=0, y=11: closest beacon is at x=2, y=10"
"Sensor at x=20, y=14: closest beacon is at x=25, y=17"
"Sensor at x=17, y=20: closest beacon is at x=21, y=22"
"Sensor at x=16, y=7: closest beacon is at x=15, y=3"
"Sensor at x=14, y=3: closest beacon is at x=15, y=3"
"Sensor at x=20, y=1: closest beacon is at x=15, y=3")
#>

$sensors = @{}
write-progress -activity "Creating sensor data" -percentcomplete "1"
$s=[int[]]@(0,0)
$b=[int[]]@(0,0)
foreach ($line in $data) {
    $temp = $line.split('=').split(',').split(':')
    $s[0] = $temp[1]
    $s[1] = $temp[3]
    $b[0] = $temp[-3]
    $b[1] = $temp[-1]
    $sensors["$($s[0]),$($s[1])"] = "$($b[0]),$($b[1])"
}
$tempGrid = $null
$grids = $null
$grids = @{}
$totalcount = $sensors.count
$count = 0
$row = "2000000"
$points = @{}
$goodPoints = @{}






foreach ($sensor in $sensors.Keys) {
    $count += 1
    write-progress -activity "Calculating Diamond Edge ... $count of $totalcount" -percentcomplete ($count/$totalcount*100)
    # I need to find the radius of the diamond
    [int[]]$s = $sensor.split(',')
    [int[]]$b = $sensors[$sensor].split(',')
    
    $radius = [math]::Abs($b[0]-$s[0]) + [math]::Abs($b[1]-$s[1]) + 1

    for ($x = 0; $x -le $radius; $x++) {
        [int]$y = $radius - $x
        $a = $s[0]+$x
        $b = $s[0]-$x
        $c = $s[1]+$y
        $d = $s[1]-$y
        if (!($a -gt 4000000 -or $b -gt 4000000 -or $c -gt 4000000 -or $d -gt 4000000 -or $a -lt 0 -or $b -lt 0 -or $c -lt 0 -or $d -lt 0)) {
            $points["$a,$c"]=$true
            $points["$a,$d"]=$true
            $points["$b,$c"]=$true
            $points["$b,$d"]=$true
        }
    }
    write-progress -activity "Calculating sensor checks ... $count of $totalcount" -percentcomplete ($count/$totalcount*100)



        foreach ($point in $points.Keys) {
            $found = $false
            foreach ($sensor in $sensors.Keys) {
                [int[]]$s = $sensor.split(',')
                [int[]]$b = $sensors[$sensor].split(',')
    
                $distance = [math]::Abs($b[0]-$s[0]) + [math]::Abs($b[1]-$s[1])
                if ([math]::Abs([int]$point.split(',')[0] - $s[0]) + [math]::Abs([int]$point.split(',')[1] - $s[1]) -le $distance) {
                    $found = $true
                    break
                }
            }
            if (!$found) {
                write-host ([int]$point.split(',')[0] * (4000000) + $point.split(',')[1])
                return 0
            }
        }
        $goodPoints
#            if ($points.length -eq1) {
#                write-host ([int]$points.split(',')[0] * (4000000) + $points.split(',')[1])
#                ""
#            }          
#        }

    
}

$winner = $goodPoints.keys
#$points = $points | select -Unique
write-host ([int]$winner.split(',')[0] * (4000000) + $winner.split(',')[1])
