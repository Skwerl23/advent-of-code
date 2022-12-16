$data = Get-Content C:\Tools\advent2022\challenge13.txt

function Compare-Arrays($left, $right) {
    $leftParts = $left.Split(",")
    $rightParts = $right.Split(",")
    for ($i = 0; $i -lt $leftParts.Length; $i++) {
        $left = $leftParts[$i]
        $right = $rightParts[$i]

        $depthLeft = ($left.length - $left.replace("[",'').length) - ($left.length - $left.replace("]",'').length)
        $depthRight = ($right.length - $right.replace("[",'').length) - ($right.length - $right.replace("]",'').length)

        $left = $left.Trim("[]")
        $right = $right.Trim("[]")

        if ($left -ne $right) {
            if ($left -and $right) {
                return [int]$left - [int]$right
            }
            return ([bool]$left) - ([bool]$right)
        }
        if ($depthLeft -ne $depthRight) {
            return $depthLeft - $depthRight
        }
    }
    return $left.Length - $right.Length
}

$count = 0
$final = 0
for ($x=0; $x -lt ($data.Length-1);$x+=3) {
$count ++
    $left = $data[$x]
    $right = $data[$x+1]
    
    if ((compare-arrays $left $right) -lt 0) {
        $final += $count
    }
}

$final
