$data = Get-Content C:\Tools\advent2022\Challenge21.txt


<#$data = @("root: pppw + sjmn"
"dbpl: 5"
"cczh: sllz + lgvd"
"zczc: 2"
"ptdq: humn - dvpt"
"dvpt: 3"
"lfqf: 4"
"humn: 5"
"ljgn: 2"
"sjmn: drzm * dbpl"
"sllz: 4"
"pppw: cczh / lfqf"
"lgvd: ljgn * ptdq"
"drzm: hmdt - zczc"
"hmdt: 32")
#>
function calculateValue ([int64]$left, [int64]$right, [string]$sign) {
    if ($sign -eq "+") {
        return $left + $right
    }
    if ($sign -eq "-") {
        return $left - $right
    }
    if ($sign -eq "/") {
        return $left / $right
    }
    if ($sign -eq "*") {
        return $left * $right
    }
}
$erroractionpreference = "SilentlyContinue"
$count=0
while (($data -match "root:").Split().length -gt 2){
    $count++ 
    $percentDone = $data -match '\:\ [0-9]*$' | measure | select -ExpandProperty count
    Write-Progress -Activity "Working" -PercentComplete (($percentDone)/$data.length*100) 
    for ($i=0; $i -lt $data.Length; $i++) {
        $left = $right = $sign = $null
        $sign = $data[$i].split(':')[1].split()[2]
        if ($sign) {
            $name = $data[$i].split(':')[0]
            $left = $data[$i].split(':')[1].split()[1]
            $right = $data[$i].split(':')[1].split()[-1]
            $continue = $true
            if ([int64]$right -is [int64] -and [int64]$left -is [int64]) {
                $answer = calculateValue $left $right $sign
                $continue = $false
            }
            if ($continue) {
                $tempLeft = ($data -match ("^$left" + ":"))
                if ($tempLeft.split().length -eq 2) {
                    if ([int64]$templeft.split()[1]) {
                        $left = $tempLeft.split()[1]
                    }
                }
                $tempright = ($data -match ("^$right" + ":"))
                if ($tempright.split().length -eq 2) {
                    if ([int64]$tempright.split()[1]) {
                        $right = $tempright.split()[1]
                    }
                }
                $answer = $left + " $sign " + $right
                
            }
            $data[$i] = "$name" + ": $answer"
#            $data
#            sleep 1
        }


    }    

}
$data -match "root:"