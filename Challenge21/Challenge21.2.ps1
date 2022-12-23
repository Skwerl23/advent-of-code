### There must be a more accurate way to do this, I sort of intelligently brute force it by going up and down one digit at a time until i hone in on the answer.
### Maybe this doesn't work in all scenarios. You may need to reverse the check signs. for the root equality response
$data = Get-Content C:\Tools\advent2022\Challenge21.txt
$data = $data.replace("root: wdzt + dffc","root: wdzt = dffc")

$humanValue = ($data -match "humn:").split()[1]

$humanCount = $data -match "humn" | measure |select -ExpandProperty count
<#
$data = @("root: pppw = sjmn"
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
#>                                  #####13439547545467

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
    if ($sign -eq '=') {
        ###Uncomment for debugging
        #write-host "$left, $right"
        if ($left -gt $right) {
            return -1
        }
        if ($left -lt $right) {
            return 1
        }
        return 0
    }
}
$erroractionpreference = "SilentlyContinue"
$count=0
### my answer was around 3900000000000
$human =    1000000000000
$modifier = 1000000000000
$dataminimized = $false
$finalCheck= $false
$finalAnswerSmall = 0
while (($data -match "root:").Split().length -gt 2){

    if ((compare-object $dataold $data) -eq $null -and !$dataminimized) {$dataminimized = $true; "Data minimized"}
    
    if (($data -match "humn" | measure | select -ExpandProperty count ) -eq $humanCount -and !$dataminimized) {
         $dataOld = $data.Clone()
    }
    $count++ 
    $percentDone = $data -match '\:\ [0-9]*$' | measure | select -ExpandProperty count
    Write-Progress -Activity "Working" -PercentComplete (($percentDone)/$data.length*100) 
    for ($i=0; $i -lt $data.Length; $i++) {
        $left = $right = $sign = $null
        $sign = $data[$i].split(':')[1].split()[2]
        if (!$dataminimized) {
            if ($data[$i] -match "humn") {continue}
        }
        if ($sign) {
            $name = $data[$i].split(':')[0]
            $left = $data[$i].split(':')[1].split()[1]
            $right = $data[$i].split(':')[1].split()[-1]
            $continue = $true
            if ([int64]$right -is [int64] -and [int64]$left -is [int64]) {
                $answer = calculateValue $left $right $sign
                if ($name -eq "root" ) {
                    if ($answer -eq 1 -and $finalcheck) {
                        "multiple answers get the solution, so this is my best guess"
                        "The Answer is greater than $finalAnswerSmall and smaller than $($human-1)"
                        return
                    }
                    if ($answer -eq -1 ) {
                        $human += $modifier
                    }
                    
                    elseif ($answer -eq 1) {
                        $human -= $modifier
                        $modifier = $modifier / 10
                        $human += $modifier
                    }
                    elseif ($answer -eq 0) {
                            if ($finalAnswerSmall -eq 0) {
                                $finalAnswerSmall = $human
                            }
                            $human+=1; $finalCheck = $true;
                            "Honing in on final answer"
                        }
                        ###Uncomment for debigging"
                        #"Human is $human"
                    $data = $dataold.Clone()
                    $data = $data.replace("humn: $humanValue","humn: $human")
                    #$answer
                    break
                }
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
        }

    }    

}
$data -match "root:"

