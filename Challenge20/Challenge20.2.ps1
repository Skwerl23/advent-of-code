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
    $data[$i] = [int64]$data[$i] * 811589153
}
for ($z = 0; $z -lt 10; $z++) {
    for ($i = 0; $i -lt $data.length; $i++) {
        $move = $data[$i]
        $index = $indexes.IndexOf($i)
        $newindex = [int64]$index + $move
        $newindex += ($data.Length-1)*1000000000
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
[int64]$answer[($zeroIndex+1000)%($data.Length)] + [int64]$answer[(2000+$zeroIndex)%($data.Length)] + [int64]$answer[(3000+$zeroIndex)%($data.Length)]
