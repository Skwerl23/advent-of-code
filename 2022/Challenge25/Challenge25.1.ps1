$data = cat "~\Downloads\input25.txt"
<#
$data = @("1=-0-2"
"12111"
"2=0="
"21"
"2=01"
"111"
"20012"
"112"
"1=-1="
"1-12"
"12"
"1="
"122")
#>
#i got the answer by manually figuring this out, no idea how to reverse it
#answer1 equals:
#$data="2-0-0=1-0=2====20XXX" # replace X's until i found the answer.
#"NEED"
#"34168440432447" # this was the sum of all my original data, and then i just worked my way up and down until i found the matching number
[INT64]$finalAnswer = 0
foreach ($line in $data) {
    $length = $line.length - 1
    [INT64]$lineAnswer=0
    for ($i = $length; $i -ge 0; $i--) {
     
                $place = $length - $i

        switch ($line[$i]) {
            "2" {$lineAnswer += (2 * [math]::Pow(5,$place))}
            "1" {$lineAnswer += (1 * [math]::Pow(5,$place))}
            "-" {$lineAnswer -= (1 * [math]::Pow(5,$place))}
            "=" {$lineAnswer -= (2 * [math]::Pow(5,$place))}
        }
    }
#    $lineanswer
    $finalAnswer += $lineAnswer
}
$finalAnswer
