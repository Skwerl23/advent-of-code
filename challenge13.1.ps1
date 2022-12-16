$data = Get-Content C:\Tools\advent2022\challenge13.txt

function Compare-Arrays($left, $right) {
    $leftParts = $left.Split(",")
    $rightParts = $right.Split(",")
    for ($i = 0; $i -lt $leftParts.Length; $i++) {
        $l = $leftParts[$i]
        $r = $rightParts[$i]

        $dl = ($l.length - $l.replace("[",'').length) - ($l.length - $l.replace("]",'').length)
        $dr = ($r.length - $r.replace("[",'').length) - ($r.length - $r.replace("]",'').length)

        $l = $l.Trim("[]")
        $r = $r.Trim("[]")

        if ($l -ne $r) {
            if ($l -and $r) {
                return [int]$l - [int]$r
            }
            return ([bool]$l) - ([bool]$r)
        }
        if ($dl -ne $dr) {
            return $dl - $dr
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
