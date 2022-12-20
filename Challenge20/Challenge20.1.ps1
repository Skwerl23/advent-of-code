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
    #while ($newindex -le 0) {$newindex += $data.Length-1}
    #while ($newindex -ge $data.Length-1) {$newindex -= $data.Length-1}
    $newindex = $newindex += ($data.Length-1)*50
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
[int]$answer[($zeroIndex+1000)%($data.Length)] + [int]$answer[(2000+$zeroIndex)%($data.Length)] + [int]$answer[(3000+$zeroIndex)%($data.Length)]
