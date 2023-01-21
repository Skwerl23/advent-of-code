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

$a = [int]$data.IndexOf($add1)+1
$b = [int]$data.IndexOf($add2)+1

"answer= " + ($a * $b)

