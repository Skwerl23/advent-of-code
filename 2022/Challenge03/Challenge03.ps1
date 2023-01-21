#Took 7285 ms to run

Measure-Command {
$rucksacks = cat C:\Tools\advent2022\challenge3.txt
$valuecount = 0
$letters = [System.Collections.ArrayList]@("a","b","c","d","e","f","g","h","i","j","k",
            "l","m","n","o","p","q","r","s","t","u","v","w","x",
            "y","z","A","B","C","D","E","F","G","H","I","J","K","L",
            "M","N","O","P","Q","R","S","T","U","V","W","X","Y","Z")
foreach ($ruck in $rucksacks) {
    $count = $ruck.length
    $half1 = ($ruck[0..(($count/2)-1)])
    $half2 = ($ruck[(($count/2))..1000])
    foreach ($letter in $letters) {
        if ($half1 -ccontains $letter -and $half2 -ccontains $letter) {
            $valuecount = $valuecount + 1 + $letters.IndexOf($letter)
        }
    }       
}
write-host "Answer 1 = $valuecount"

$valuecount = 0
foreach ($ruck in (0..(($rucksacks.count/3) - 1))) {
    $c = $rucksacks[($ruck*3) + 2].ToCharArray()
    $b = $rucksacks[($ruck*3) + 1].ToCharArray()
    $a = $rucksacks[$ruck*3].ToCharArray()
    foreach ($letter in $letters) {
        if ($a -ccontains $letter -and $b -ccontains $letter -and $c -ccontains $letter) {
                $valuecount = $valuecount + 1 + $letters.IndexOf($letter)
                $answer = $letter
        }
    }       
}

write-host "Answer 2 = $valuecount"

} | select @{N="Elapsed Time in Milliseconds"; E={$_.TotalMilliseconds}}