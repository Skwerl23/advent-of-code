
### This took approx 2547 milliseconds 

Measure-Command {

$data = Get-Content C:\Tools\advent2022\Challenge20.txt
<#
$data = @("1"
"2"
"-3"
"3"
"-2"
"0"
"4")
#>
$indexes = [System.Collections.ArrayList]@()
for ($i = 0; $i -lt $data.length; $i++) {
    $indexes.Add($i) | Out-Null
}

for ($i = 0; $i -lt $data.length; $i++) {
    $move = $data[$i]
    $index = $indexes.IndexOf($i)
    $newindex = $index + $move
    #If i make this any bigger than 100000 on c# it completely breaks the answer but not in powershell, very interesting.
    $newindex = $newindex += ($data.Length-1)*10000
    $newindex= $newindex % ($data.Length-1)
    $value = $indexes[$index]
    $indexes.RemoveAt($index)
    $indexes.Insert($newindex, $value)
}

$answer = @()
foreach ($item in $indexes) {
    $answer+= $data[$item]
}
$zeroIndex = $answer.indexof("0")
write-host "Answer 1 = " ([int]$answer[($zeroIndex+1000)%($data.Length)] + [int]$answer[(2000+$zeroIndex)%($data.Length)] + [int]$answer[(3000+$zeroIndex)%($data.Length)])

## Part 2, i find it easier to work each one separate, but it is possible to just make new arrays for each half.

$data = Get-Content C:\Tools\advent2022\Challenge20.txt
$indexes = [System.Collections.ArrayList]@()
for ($i = 0; $i -lt $data.length; $i++) {
    $indexes.Add($i) | Out-Null
    $data[$i] = [double]$data[$i] * 811589153
}
for ($z = 0; $z -lt 10; $z++) {
    for ($i = 0; $i -lt $data.length; $i++) {
        $move = $data[$i]
        $index = $indexes.IndexOf($i)
        $newindex = [double]$index + $move
        $newindex += ($data.Length-1)*10000
        $newindex= $newindex % ($data.Length-1)
        while ($newindex -le 0) {$newindex += ($data.Length-1)}
        $value = $indexes[$index]
        $indexes.RemoveAt($index)
        $indexes.Insert($newindex, $value)
    }
}
$answer = @()
$count = 0
foreach ($item in $indexes) {
    if ($data[$item] -eq 0) {
        $zeroIndex = $count
    }
        $count++
    $answer+= $data[$item]
}
write-host "Answer 2 = " ([double]$answer[($zeroIndex+1000)%($data.Length)] + [double]$answer[(2000+$zeroIndex)%($data.Length)] + [double]$answer[(3000+$zeroIndex)%($data.Length)])

} | select @{N="milliseconds to finish"; E={$_.TotalMilliseconds}}
