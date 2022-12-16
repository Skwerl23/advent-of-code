$data = Get-Content C:\Tools\advent2022\challenge16.txt

<#$data = @("Valve AA has flow rate=0; tunnels lead to valves DD, II, BB"
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

$valves = @{}
foreach ($valve in $data) {
    $name = $valve.split()[1] # example is "CX"
    $rate = [int]$valve.split()[4].split('=')[1].split(';')[0] #Example is "3"
    $leadsto = @($valve.split()[9..20].trim(', ')) # Example is "ZN, AM, OE, YS, QE"

    $valves[$name]=@{flowrate = $rate; "connections" = $leadsto}
}

$maxvalue = 0  
$script:maxPressure = 0
#$script:path = New-Object System.Collections.ArrayList
# Define a function for performing depth-first search
function DepthFirstSearch($tree, $startNode, $timeRemaining) {
    # Initialize an arraylist to store the path and the maximum pressure achieved so far
    
    
    $visited = @{}

    # Recursive function for traversing the tree
    function Traverse($node, $time, $pressure) {
        if ($time -eq 0) {return}
        # Add the current node to the path
#        $script:path.Add($node)

        # Calculate the flow rate and time remaining if the current node is opened
        $flowRate = $valves[$node].flowrate
#        write-host "$time, $node, $flowrate, $pressure"
        [int]$timeRemainingnow = $time - 1
      #  write-host $path
        # Update the maximum pressure if the current flow rate and time remaining are greater
        $visitYes = $false
        foreach ($flow in @($flowrate,0)) {

            if ($flowrate -gt 0 -and $timeremainingnow -gt 1 -and !($visited[$node])) {
                $timeremainingnow -=1
                $pressure += $flowRate * $timeremainingnow

                if ($pressure -gt $script:maxPressure) {
                    $script:maxPressure = $pressure
                    write-host "$Pressure, $timeRemainingnow"
                }
                $visited[$node] += 1
                $visitYes = $true

            }
            # Get the list of connected nodes

            # Recursively traverse the connected nodes
            foreach ($nextNode in $valves[$node].connections) {

                Traverse $nextNode $timeremainingnow $pressure
#                $script:path = [System.Collections.ArrayList]$path[0..($path.count - 2)]
            }
            if ($visitYes) {
                $visited[$node]-=1
                $visitYes = $false
            }    
        }

        # Remove the current node from the path

    }

    # Start the traversal at the start node
    Traverse $startNode $timeRemaining 0

    # Return the maximum pressure achieved
    return $maxPressure
}



# Example function for getting the list of connected nodes
function GetConnectedNodes($node) {
    # Return a fixed list of connected nodes for demonstration purposes
    return $valves[$node].connections
}


$result = DepthFirstSearch $valves "JC" 30
Write-Output "Maximum pressure: $result"
