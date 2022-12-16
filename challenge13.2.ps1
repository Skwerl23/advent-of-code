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

$add1 = "[[2]]"
$data += $add1
$add2 = "[[6]]"
$data += $add2
$data = $data | where {$_ -match '.'}

$final = 0
$notSorted = $true
while ($notSorted) {
    $notsorted = $false
    for ($i = 0; $i -lt $data.Length-1; $i++) {
        $left = $data[$i]
        $right = $data[$i+1]
        if ((compare-arrays $left $right) -ge 1) {
            $swap = $left.Clone()
            $data[$i] = $right.Clone()
            $data[$i+1] = $swap
            $notSorted=$true
        }

    }
    
}

$a = $data.IndexOf($add1)+1
$b = $data.IndexOf($add2)+1
"answer= " + ($a * $b)

