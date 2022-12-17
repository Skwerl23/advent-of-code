$data = Get-Content C:\Tools\advent2022\challenge16a.txt
#$data = $data | sort
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
$script:visitedCombos = @()
$script:visitedPath = [System.Collections.ArrayList]@()
#$$script:visitedPath = New-Object System.Collections.ArrayList
# Define a function for performing depth-first search
function DepthFirstSearch($tree, $startNode, $timeRemaining) {
    # Initialize an arraylist to store the path and the maximum pressure achieved so far
    
    


    # Recursive function for traversing the tree
    function Traverse($node, $time, $pressure) {
        if ($time -le 5) {return}
        # Add the current node to the path
#        $$script:visitedPath.Add($node)
        
        #write-host ($path -join ' ') + " $time"
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
                #$timeRemainingnow -=1
                $pressureold = $pressure
                $pressureChange = ($flow * [int]($timeRemainingnow))
                $pressure += $pressureChange
                $script:visited[$node]=$timeRemainingnow
                $local:nodeName = $node + ",$timeremainingnow"

                $script:visitedPath.add($local:nodeName)| Out-Null
                $script:visitedCombos += $script:visitedPath -join ' '
#                if ($pressure -gt $script:maxPressure) {
#                    $script:maxPressure = [math]::Max($pressure,$script:maxPressure)
                    #write-host $visited.Keys
#                    write-host "$pressureold, $pressure, $timeRemainingnow, $($script:visitedPath), ($flow * $timeRemainingnow)"
                    
#                $sum = 0
#                foreach ($place in $script:visitedPath) {
#                    $sum += $valves[$place.split(',')[0]].flowrate * [int]$place.split(',')[1]
#                }
                #write-host "Sum = $sum"
                #write-host ""
                    
                #}
                $visitYes = $true

            }

            foreach ($nextNode in $visitableValves | where {$_ -notin $visited.Keys}) {
                $timeToNode = $timeToValves[$node][$nextNode]
                if ($timeRemainingnow - $timeToNode -gt 0) {
                    Traverse $nextNode ($timeremainingnow-$timeToNode-1) $pressure
                    if ($maxtime -gt 0) {break}
                }

            }
           # $pressure -= $pressurechange
            $script:visitedPath.Remove($local:nodeName)
#            $timeRemainingnow+=1

            if ($visitYes) {

                $visitYes = $false

                if ($maxtime -eq $visited[$node]) {
                    $maxtime = 0
                }
                $script:visited.remove($node)
            }
        
       # }
        # Remove the current node from the path

    }

    # Start the traversal at the start node
    Traverse $startNode $timeRemaining 0

    # Return the maximum pressure achieved
   # return $maxPressure
}



# Example function for getting the list of connected nodes
function GetConnectedNodes($node) {
    # Return a fixed list of connected nodes for demonstration purposes
    return $valves[$node].connections
}

$maxsum = 0
DepthFirstSearch $valves $startValve 26
#Write-Output "Maximum pressure: $result"
foreach ($combo in $script:visitedCombos) {
    $combo = $combo.split()
    foreach ($combo2 in $script:visitedCombos) {
        $combo2 = $combo2.split()
        $fail = $false
        foreach ($item in $combo) {
            if ($combo2 -match $item.Split(',')[0]) {
                $fail = $true
                break
            }
        }
        if (!$fail) {
            $sum = 0
            foreach ($item in $combo) {
                $sum += $valves[$item.split(',')[0]].flowrate * [int]$item.split(',')[1]
            }

            foreach ($item in $combo2) {
                $sum += $valves[$item.split(',')[0]].flowrate * [int]$item.split(',')[1]
            }
            $maxsum = [math]::Max($sum, $maxsum)
        }
    }

}



$maxsum


