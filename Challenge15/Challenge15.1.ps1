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
foreach ($line in $data) {
    $temp = $line.split('=').split(',').split(':')
    $sx = $temp[1]
    $sy = $temp[3]
    $bx = $temp[-3]
    $by = $temp[-1]
    $sensors["$($sx),$($sy)"] = "$($bx),$($by)"
}
$tempGrid = $null
$grids = $null
$grids = @{}
$totalcount = $sensors.count
$count = 0
$row = "2000000"

foreach ($sensor in $sensors.Keys) {
    $count += 1
    write-progress -activity "Calculating line lengths ... $count of $totalcount" -percentcomplete ($count/$totalcount*100)
    # I need to find the radius of the diamond
    $sx = [int]$sensor.split(',')[0]
    $sy = [int]$sensor.split(',')[1]
    $bx = [int]$sensors[$sensor].split(',')[0]
    $by = [int]$sensors[$sensor].split(',')[1]
    
    $radius = [math]::Abs($bx-$sx) + [math]::Abs($by-$sy)

    if ([math]::Abs($row - $sy) -le $radius) {
        $linelength = ($radius - [math]::Abs($row - $sy))
        if ($linelength -gt 0) {
            foreach ($i in $sx..($sx-$linelength)) {
                $grids["$i,$row"] = $true 
            }
            foreach ($i in ($sx+1)..($sx+$linelength)) {
                $grids["$i,$row"] = $true 
            }
        }
    }

}

write-progress -activity "Calculating Answer" -percentcomplete "99"



$spaces = $grids.count 
$beacons = $sensors.Values -match ",$row" | select -Unique | measure | select -ExpandProperty count

$answer = $spaces - $beacons
$answer
write-progress -activity "Calculating Answer" -percentcomplete "99" -completed
