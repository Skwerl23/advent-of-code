### There must be a more accurate way to do this, I sort of intelligently brute force it by going up and down one digit at a time until i hone in on the answer.
### After looking at other solutions, people did a binary search. which is sort of like what i did. 
#### Binary search goes by trying splitting the difference. so for example if the answer is 37 a binary search would do this:
### start with 0 and 100. if 50 is too high, set 100 to 50. now try 25. it's too low, set 0 to 25. now try 37. (half way 25-50) it's too high. and so on
### What i did was try most significant bit, if not high enough add 1. try again, if too high, subtract 1 and move down a tens place. for example
### if 1000 is too low, try 2000. if 2000 is too high, try 2000-1000+100 or 1100. too low, try 1200..1300..1400 oh too high, now try 1310 etc...
### obviously the binary search is faster.
### out of a trillion we'd cut it to 500b then 250b then 125 b and so on. but thats 3 moves.
### my method cuts 1trillion to 900b then 800b and has to try an average of 5 per place. so 70 tries on average, but could be 24 tries and could be 132 tries.
###splitting in half... means it takes 40 tries every time no matter what
### my method took approx 72 tries for my answer. if you have lower numbers say 3 digits it takes 10 tries, where my method takes 17.
###so binary search seems to always be faster in terms of statistics. 
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

