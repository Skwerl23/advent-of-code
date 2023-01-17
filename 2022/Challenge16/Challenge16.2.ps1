$data = Get-Content C:\Tools\advent2022\challenge16.txt
#$data = $data | sort
### Finally got this working. Anyhow, it's not too slow now
### the hashmap variant of visitedcombos is 100s of times faster. and sorting the list by value finds the answer fast
<#
$data = @("Valve AA has flow rate=0; tunnels lead to valves DD, II, BB"
"Valve BB has flow rate=13; tunnels lead to valves CC, AA"
"Valve CC has flow rate=2; tunnels lead to valves DD, BB"
"Valve DD has flow rate=20; tunnels lead to valves CC, AA, EE"
"Valve EE has flow rate=3; tunnels lead to valves FF, DD"
"Valve FF has flow rate=0; tunnels lead to valves EE, GG"
"Valve GG has flow rate=0; tunnels lead to valves FF, HH"
"Valve HH has flow rate=22; tunnel leads to valve GG"
"Valve II has flow rate=0; tunnels lead to valves AA, JJ"
"Valve JJ has flow rate=21; tunnel leads to valve II")
#>
##example line of input: Valve CX has flow rate=3; tunnels lead to valves ZN, AM, OE, YS, QE
### This code takes longer than I'd like, but it completes
$startValve = "AA"
$valves = @{}
foreach ($valve in $data) {
    $name = $valve.split()[1] # example is "CX"
    $rate = [int]$valve.split()[4].split('=')[1].split(';')[0] #Example is "3"
    $leadsto = @($valve.split()[9..20].trim(', ')) # Example is "ZN, AM, OE, YS, QE"

    $valves[$name]=@{flowrate = $rate; "connections" = $leadsto}
}
$timeToValves = @{}
foreach ($valve in $valves.keys) {
    $timeToValves[$valve] = @{}
    foreach ($connection in $valves.values.connections) {
        if ($valves[$valve].connections -Contains $connection) {
            $timeToValves[$valve][$connection] = [float]1
        }
        else {
            $timeToValves[$valve][$connection] = [float]::PositiveInfinity
        }
    }
}
foreach ($k in $timeToValves.Keys) {
    foreach ($i in $timeToValves.Keys) {
        foreach ($j in $timeToValves.Keys) {
            $timeToValves[$i][$j] = [Math]::Min($timeToValves[$i][$j], ($timeToValves[$i][$k] + $timeToValves[$k][$j]))
        }
    }
}
$visitableValves = $valves.keys | where {$valves[$_].flowrate -ne 0} | sort {$valves[$_].flowrate} -Descending
$maxvisits = $valves.Values | where flowrate -ne 0 | measure | select -ExpandProperty count
$maxtime = 0  
$script:maxPressure = 0
$script:vispath = @()
$script:visited = @{}
$script:visitedCombos = @{}
$script:visitedPath = [System.Collections.ArrayList]@()

function DepthFirstSearch($tree, $startNode, $timeRemaining) {

    # Recursive function for traversing the tree
    function Traverse($node, $time, $pressure) {
        if ($time -le 1) {return}
        # Calculate the flow rate and time remaining if the current node is opened
        [int]$timeRemainingnow = $time #-1
        $flow = $valves[$node].flowrate
        foreach ($valve in $script:visited | sort values -Descending | select -expand keys) {
        
        if ($flow -gt ($visited[$valve] - $timeRemainingnow) * $valves[$valve].flowrate) {
            $maxtime = $visited[$node]

            return

        }


        }

        $visitYes = $false

       # foreach ($flow in $flowrate) {
            
            if ($flow -gt 0 -and ($script:visited[$node] -eq $null)) {
                $pressureold = $pressure
                $pressureChange = ($flow * [int]($timeRemainingnow))
                [int]$pressure += $pressureChange
                $script:visited[$node]=$timeRemainingnow
                $local:nodeName = $node 

                $script:visitedPath.add($local:nodeName)| Out-Null

                $script:visitedCombos[($script:visitedPath | sort) -join ' '] = [math]::max([int]$script:visitedCombos[($script:visitedPath | sort) -join ' '], $pressure)
                $visitYes = $true

            }

            foreach ($nextNode in $visitableValves | where {$_ -notin $visited.Keys}) {
                $timeToNode = $timeToValves[$node][$nextNode]
                if ($timeRemainingnow - $timeToNode -gt 0) {
                    Traverse $nextNode ($timeremainingnow-$timeToNode-1) $pressure
                    if ($maxtime -gt 0) {break}
                }

            }
            $script:visitedPath.Remove($local:nodeName)

            if ($visitYes) {

                $visitYes = $false

                if ($maxtime -eq $visited[$node]) {
                    $maxtime = 0
                }
                $script:visited.remove($node)
            }
        

    }

    # Start the traversal at the start node
    Traverse $startNode $timeRemaining 0

}

$maxsum = 0

DepthFirstSearch $valves $startValve 26

"We found this many combos"
$script:visitedCombos.keys | measure | select -expand count

$total = $script:visitedCombos.Count
$count = 0
foreach ($combo in $script:visitedCombos.GetEnumerator() | sort {$_.Value} -Descending | select -ExpandProperty key) {
    $count++
    if ($count % 50 -eq 0) {
        Write-Progress -Activity "working $count of $total - highest sum found is $maxsum" -PercentComplete ($count/$total*100)
    }
    $comboCheck = $combo.split()
    foreach ($combo2 in $script:visitedCombos.GetEnumerator() | sort {$_.Value} -Descending | select -ExpandProperty key) {
        if ($visitedCombos[$combo2] + $visitedCombos[$combo] -lt $maxsum) {break} 
        $combo2Check = $combo2.split()
        $fail = $false
        if ((Compare-Object $combo2Check $comboCheck -IncludeEqual -ExcludeDifferent | select -expand sideindicator )) {
            $fail = $true
        }
        if (!$fail) {

            $maxsum = [math]::Max($visitedCombos[$combo2] + $visitedCombos[$combo], $maxsum)
        }
    }

}


#### You can let this run to the end, but after 1-200 rounds it's basically done due to the nature of the sorting.
$maxsum


