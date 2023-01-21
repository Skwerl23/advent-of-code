#Took about 1560 ms to run
Measure-Command {

    $signal = cat C:\Tools\advent2022\challenge6.txt

    for ($turn =0; $turn -lt 2; $turn++) {
        $gap = $turn*10 + 4
        foreach ($num in 0..$signal.Length) {
            $list = @()
            foreach ($i in 0..($gap-1)) {
                $list += $signal[$num+$i]
            }
            if (($list | select -Unique | measure | select count) -match $gap) {
                Write-host "Answer $($turn+1) = $($num+$gap)"
                break
            }
        }
    }

} | select @{N="Elapsed Time in Milliseconds"; E={$_.TotalMilliseconds}}
