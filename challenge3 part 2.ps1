$rucksacks = cat C:\Tools\advent2022\challenge3.txt
$valuecount = 0
$letters = [System.Collections.ArrayList]@("a","b","c","d","e","f","g","h","i","j","k",
            "l","m","n","o","p","q","r","s","t","u","v","w","x",
            "y","z","A","B","C","D","E","F","G","H","I","J","K","L",
            "M","N","O","P","Q","R","S","T","U","V","W","X","Y","Z")

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
$valuecount