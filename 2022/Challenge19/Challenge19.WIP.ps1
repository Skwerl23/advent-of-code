
###
###  THIS IS NOT A WORKING SOLUTION, IT IS STILL A WORK IN PROGRESS
###
###






$ErrorActionPreference = "SilentlyContinue"
function max-geodes([int]$ore, [int]$clay, [int]$obsidian, [int]$minutes_remaining, $blueprint, [int]$geodesMade) {
    if ($script:geodesbeingmade) {
        $geodesMade += [int]($blueprint.geodes_per_minute)
        write-host $geodesMade
        $script:geodesbeingmade = $false
    }

    if ($minutes_remaining -eq 0 -or $minutes_remaining -lt $script:max_geodes) {
        return [int]$geodesMade
    }
  
    $max_geodes = 0
  
    if ($ore -ge $blueprint.ore_ore_cost) {
        $blueprint.ore_per_minute += 1
        [int]$ore_geodes = max-geodes ($ore - $blueprint.ore_cost) $clay $obsidian ($minutes_remaining - 1) $blueprint $geodesMade
        [int]$max_geodes = [Math]::Max($max_geodes, $ore_geodes)
        [int]$script:max_geodes = [Math]::Max($max_geodes, $ore_geodes)
        $blueprint.ore_per_minute -= 1

    }
  
    if ($ore -ge $blueprint.clay_ore_cost) {
        $blueprint.clay_per_minute += 1
        [int]$clay_geodes = max-geodes ($ore - $blueprint.clay_cost) $clay $obsidian ($minutes_remaining - 1) $blueprint $geodesMade
        [int]$max_geodes = [Math]::Max($max_geodes, $clay_geodes)
        [int]$script:max_geodes = [Math]::Max($max_geodes, $clay_geodes)
        $blueprint.clay_per_minute -= 1
    }
  

    if ($ore -ge $blueprint.obsidian_ore_cost -and $clay -ge $blueprint.obsidian_clay_cost) {
        $blueprint.obsidian_per_minute = $blueprint.obsidian_per_minute + 1
        [int]$obsidian_geodes = max-geodes ($ore - $blueprint.obsidian_cost) ($clay - $blueprint.obsidian_clay_cost) $obsidian ($minutes_remaining - 1) $blueprint $geodesMade
        [int]$max_geodes = [Math]::Max($max_geodes, $obsidian_geodes)
        [int]$script:max_geodes = [Math]::Max($max_geodes, $obsidian_geodes)
        $blueprint.obsidian_per_minute -= 1
        
    }

    if ($ore -ge $blueprint.geode_ore_cost -and $obsidian -ge $blueprint.geode_obsidian_cost) {
        $blueprint.geodes_per_minute += 1
        $script:geodesbeingmade = $true
        [int]$geode_geodes = max-geodes ($ore - $blueprint.geode_cost) $clay ($obsidian - $blueprint.geode_obsidian_cost) ($minutes_remaining - 1) $blueprint $geodesMade
        [int]$max_geodes = [Math]::Max($max_geodes, $geode_geodes)
        [int]$script:max_geodes = [Math]::Max($max_geodes, $geode_geodes)
        $blueprint.geodes_per_minute -= 1
        
    }
    if ($minutes_remaining -gt 0) {
        $extra = max-geodes ($ore + $blueprint.ore_per_minute) ($clay + $blueprint.clay_per_minute) ($obsidian + $blueprint.obsidian_per_minute) ($minutes_remaining-1) $blueprint $geodesMade
        [int]$max_geodes = [Math]::Max($max_geodes, $extra)
        [int]$script:max_geodes = [Math]::Max($max_geodes, $extra)
    }

    return [int]($max_geodes)
}



$data = cat C:\Tools\advent2022\Challenge19.txt

$data = @("Blueprint 1: Each ore robot costs 4 ore. Each clay robot costs 2 ore. Each obsidian robot costs 3 ore and 14 clay. Each geode robot costs 2 ore and 7 obsidian."
          "Blueprint 2: Each ore robot costs 2 ore. Each clay robot costs 3 ore. Each obsidian robot costs 3 ore and 8 clay. Each geode robot costs 3 ore and 12 obsidian.")
$script:geodesbeingmade = $false
foreach ($blueprintinfo in $data) {
    $line = $blueprintinfo.split('. :')
    $number = $line[1]
    $oreRobotOreCost = $line[7]
    $clayRobotOreCost = $line[14]
    $obsidianRobotOreCost = $line[21]
    $obsidianRobotClayCost = $line[24]
    $geodeRobotOreCost = $line[31]
    $geodeRobotObsidianCost = $line[34]

    $blueprint = [pscustomobject]@{
        ore_ore_cost = [int]$oreRobotOreCost
        clay_ore_cost = [int]$clayRobotOreCost
        obsidian_ore_cost = [int]$obsidianRobotOreCost
        obsidian_clay_cost = [int]$obsidianRobotClayCost
        geode_ore_cost = [int]$geodeRobotOreCost
        geode_obsidian_cost = [int]$geodeRobotObsidianCost
        ore_per_minute = 1
        clay_per_minute = 0
        obsidian_per_minute = 0
        geodes_per_minute = 0
    }
    $script:max_geodes = 0
    $answer = max-geodes 0 0 0 24 $blueprint 0
    $sum += $answer*$number
}
$sum
