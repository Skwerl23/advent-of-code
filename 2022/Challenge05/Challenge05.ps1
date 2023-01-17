#Took 200ms to run
Measure-Command {
$rules = cat C:\Tools\advent2022\challenge5.txt

$stacks = $rules[0..8]
$moves = $rules[10..$rules.Length]
 
$a = @([char[]]@(),[char[]]@(),[char[]]@(),[char[]]@(),[char[]]@(),[char[]]@(),[char[]]@(),[char[]]@(),[char[]]@())
$b = @([char[]]@(),[char[]]@(),[char[]]@(),[char[]]@(),[char[]]@(),[char[]]@(),[char[]]@(),[char[]]@(),[char[]]@())


foreach($x in 0..7) {
    foreach ($i in 0..8) {
        if ($stacks[$x][($i*4)+1] -ge "A" -and $stacks[$x][($i*4)+1] -le "Z") { 
            $a[$i] += [char]$stacks[$x][($i*4)+1]
            $b[$i] += [char]$stacks[$x][($i*4)+1]
        }
    }
}
#sleep 30
foreach ($m in $moves) {
    $x = [int]$m.Split(' ')[3] - 1
    $y = [int]$m.Split(' ')[5] - 1
    #Stack part a in top to bottom order
    for ($q = 0; $q -lt [int]$m.Split(' ')[1]; $q++) {
            $a[$y] = [char[]]$a[$x][0] + [char[]]$a[$y]
            $a[$x] = [char[]]$a[$x][1..($a[$x].Length)]
    }

    # stack part b as complete moves
    [char[]]$b[$y] = $b[$x][0..([int]$m.Split(' ')[1] - 1)] + $b[$y]
    [char[]]$b[$x] = [char[]]$b[$x][([int]$m.Split(' ')[1])..($b[$x].length)]

}

$answer = foreach ($x in 0..8) {
    $a[$x][0]
}
$answer2 = foreach ($x in 0..8) {
    $b[$x][0]
}
write-host "Answer 1 = $($answer -join '')"
write-host "Answer 2 = $($answer2 -join '')"
} | select @{N="Elapsed Time in Milliseconds"; E={$_.TotalMilliseconds}}
