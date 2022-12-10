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
$valuecount