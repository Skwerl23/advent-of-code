## My powershell version here uses incremental numbers, instead of a binary split search.
## I will re-write this to support binary search, but for now it might be slower than expected

# The old method took around 869946 milliseconds
# udpdating to binary search took 596809 milliseconds - about a 31% reduction

Measure-Command {

$data = Get-Content C:\Tools\advent2022\Challenge21.txt


<#
$data = @("root: pppw / sjmn"
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
function calculateValue ([double]$left, [double]$right, [string]$sign) {
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
        if ($left -gt $right) {
            return -1
        }
        if ($left -lt $right) {
            return 1
        }
        return 0
    }
}
#
$erroractionpreference = "SilentlyContinue"
$count=0
while (($data -match "root:").Split().length -gt 2){
    $count++ 
    for ($i=0; $i -lt $data.Length; $i++) {
        $left = $right = $sign = $null
        $sign = $data[$i].split(':')[1].split()[2]
        if ($sign) {
            $name = $data[$i].split(':')[0]
            $left = $data[$i].split(':')[1].split()[1]
            $right = $data[$i].split(':')[1].split()[-1]
            $continue = $true
            if ([double]$right -match '\d' -and [double]$left -match '\d') {
                $answer = calculateValue $left $right $sign
                $continue = $false
            }
            if ($continue) {
                $tempLeft = ($data -match ("^$left" + ":"))
                if ($tempLeft.split().length -eq 2) {
                    if ([double]$templeft.split()[1]) {
                        $left = $tempLeft.split()[1]
                    }
                }
                $tempright = ($data -match ("^$right" + ":"))
                if ($tempright.split().length -eq 2) {
                    if ([double]$tempright.split()[1]) {
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

$answer1 = $data -match "root:"
write-host "answer to 1 = $answer1"
#>
$data = Get-Content C:\Tools\advent2022\Challenge21.txt

$humanValue = ($data -match "humn:").split()[1]

$humanCount = $data -match "humn" | measure |select -ExpandProperty count

$erroractionpreference = "SilentlyContinue"
$count=0
### my $answer was around 3900000000000

$humanmax =       [double]10000000000000
$humanmin = [double]0
$dataminimized = $false
$finalCheck= $false
$finalanswerSmall = 0
$pattern = '^root:\s\d+$'
$total = 64 # this is an overshoot, it's more like 40 rounds
$dataold = @()
$trials = 0

while ( !($data -match $pattern)) {
    write-progress -Activity "Working.. data minimized is $dataminimized .. testing value $testvalue .. completed trial $trials" -PercentComplete ($trials/ $total * 100)

    if (!$dataminimized) { 
        if (!(Compare-Object $dataold $data)) {$dataminimized = $true; write-host "data minimized"}
                    
        if (($data | sls "humn" | measure | select -expand Count) -eq 2) {
            $dataOld = $data.Clone()
        }
    }
    $restart = $false
    $testValue = [Math]::Round(($humanMax + $humanMin) / 2)
    if ($dataminimized) {
        $index = $data.Indexof("humn: $humanValue")
        if ($index -ne -1) {
            $data[$index] = "humn: " + $testValue
        }
    }
    for ($i=0; $i -lt $data.Count; $i++) {
        if (!$dataminimized) {
            if ($data[$i].Contains("humn")) {continue}
        }

        if ($data[$i].split(' ').Length -gt 2) {
            $sign = $data[$i].Split(':')[1].Split(' ')[2]
            $left = ""
            $right = ""
            $leftLong = "blank"
            $rightLong = "blank"
            $name = $data[$i].Split(':')[0]
            $left = $data[$i].Split(':')[1].Split(' ')[1]
            $right = $data[$i].Split(':')[1].Split(' ')[-1]
            if ($left -match '\d' -and $right -match '\d' -and $name -ne "root") {
                $answer = calculateValue $left $right $sign
            }
            else  {
                if (!($left -match '\d')) {
                    $tempLeft = "^" + $left + ":"
                    $tempLeft = $data | sls $tempLeft
                    if (($tempLeft -split ' ' | measure | select -ExpandProperty count) -eq 2) {
                        $leftLong = [double](($tempLeft -split ' ')[-1])
                    }
                } else {$leftLong = [double]$left}
                if (!($right -match '\d')) {
                    $tempRight = "^" + $right + ":"
                    $tempRight = $data | sls $tempRight
                    if (($tempRight -split ' ' | measure | select -ExpandProperty count) -eq 2) {
                        $rightLong = [double](($tempRight -split ' ')[-1])
                    }
                } else {$rightLong = [double]$right}
                if ($leftLong -ne "blank" -and $rightLong -ne "blank") {

                    if ($name -eq "root") {
#                        write-host "$leftLong $rightLong"
                    
                        if ((calculateValue $leftLong $rightLong '=') -eq 0) {
                            $answer = $testValue
                        }
                        elseif ((calculateValue $leftLong $rightLong '=') -eq 1) {
                            $humanMax = $testValue
                            $restart = $true
                        }
                        elseif ((calculateValue $leftLong $rightLong '=') -eq -1) {
                            $humanMin = $testValue
                            $restart = $true
                        }
                    }
                    else {
                        $answer = [math]::round((calculateValue $leftLong $rightLong $sign))
                    }

                }
                elseif ($leftLong -ne "blank" -and $rightLong -eq "blank") {
                    $answer = "$leftLong $sign $right"
                }
                elseif ($leftLong -eq "blank" -and $rightLong -ne "blank") {
                    $answer = "$left $sign $rightLong"
                }
                else {
                    $answer = "$left $sign $right"
                }
            }
            if ($restart) {
                $trials += 1
                $data = $dataOld.Clone()
                break
            }
            $data[$i] = "$($name): $answer"
        }
    }


}
write-host "answer 2 = $testValue"

} | select @{N="milliseconds to finish"; E={$_.TotalMilliseconds}}