Measure-Command {

$data = cat C:\Tools\advent2022\Challenge22a.txt 
#uncomment the else statements for a trail of X's, it does eventually break the script
# but it is very useful for trail hunting. 

<#
$data = @(
"        ...#"
"        .#.."
"        #..."
"        ...."
"...#.......#"
"#.......#..."
"..#....#...."
"..........#."
"        ...#...."
"        .....#.."
"        .#......"
"        ......#."
""
"10R5L5R10L4R5L5")
#>
function get-new-pos ([int]$row, [int]$col, [string]$direction) {
    if ($row -eq 0 -and $col -lt 101) {
        #top of side 0 touches left of 5
        return @(($col + 100), 1, "right")
    }
    elseif ($row -eq 0 -and $col -gt 100) {
        #Top of side 1 touches bottom of 5
        return @(200, ($col - 100), "up")
    }
    elseif ($row -lt 51 -and $col -eq 50) {
        #left of side 0 touches left of side 3 - flipped
        return @((151 - $row), 1, "right")
    }
    elseif ($col -eq 151) {
        #right of side 1 touches right of side 4 - flipped
        return @((151 - $row), 100, "left")
    }
    elseif ($row -eq 51 -and $direction -eq "down") {
        #bottom of side 1 touches right of side 2 if direction is down
        return @(($col - 50), 100, "left")
    }
    elseif ($row -gt 50 -and $col -eq 50 -and $direction -eq "left") {
        #left of side 2 touches top of side 3 if direction is left
        return @(101,($row - 50), "down")
    }
    elseif ($row -gt 50 -and $row -lt 101 -and $col -eq 101 -and $direction -eq "right") {        
        #right of side 2 touches bottom of side 1 if direction is right
        return @(50,($row+50), "up")
    }

    elseif ($row -eq 100 -and $col -lt 51 -and $direction -eq "up") {
        #top of side 3 touches left of side 2 if direction is up
        return @(($col+50),51,"right")
    }

    elseif ($col -eq 0 -and $row -gt 100 -and $row -lt 151) {
        #left of side 3 touches left of side 0
        return @((151-$row),51, "right")
    }

    elseif ($col -eq 101 -and $row -gt 100 -and $row -lt 151) {
        #right of side 4 touches right of side 1 - flipped
        return @((151 - $row),150, "left")
    }

    elseif ($row -eq 151 -and $direction -eq "down") {
        #bottom of side 4 touches right of side 5 if direction is down
        return @(($col+100),50, "left")
    }

    elseif ($row -gt 150 -and $col -eq 0) {
        #left of side 5 touches top of side 0 
        return @(1,($row-100), "down")
    }

    elseif ($row -gt 150 -and $col -eq 51 -and $direction -eq "right") {
        #right of side 5 touches bottom of side 4 if direction is right
        return @(150,($row-100), "up")
    }

    elseif ($row -eq 201) {
        #bottom of side 5 touches top of side 1
        return @(1,($col + 100), "down")
    }


}

$grid = @()
$grid += ,([char[]]" "*152)
foreach ($row in $data[0..($data.Length-2)]) {
    $grid+= ,([char[]](" " + $row + (" "*(150 - $row.length ) + " ")))    
}
#$grid += ,([char[]]" "*200)

$moves = $data[-1] + "L"

$data = $grid.clone()


$number = ""
$moving = "right"
$col = 51
$row = 1

foreach ($i in 0..($moves.Length-1)) {
    Write-Progress -Activity "Working" -PercentComplete ($I / $moves.Length * 100)
    $letter = $moves[$i]

    if ($i -eq $moves.length-1) {$finalmoving = $moving}
    if ("LR" -match $letter) {
        [int]$mathNumber = [int]$number
        $number = ""
        #uncomment for debugging
        #"I am moving $mathNumber $moving and then turning left"
    
        $break = $false

        if ($moving -eq "right") {
            if ($letter -eq "L") {
                $moving = "up"
            } else {$moving = "down"}
            $num=0
            while ($num -lt $mathNumber) {
                $num++
                if ($break) {break}
                $col+=1
                $start = [int]$col
                if ($data[$row][$col] -eq "#") {
                    $col-=1
                    break
                }        
                elseif ($data[$row][$col] -eq " ") {
                    $num--
                    $col = 0
                    while ($data[$row][$col] -ne ".") {

                        $col+=1
                        if ($data[$row][$col] -eq "#") { $col = [int]$start + 0; $break = $true; break}
                    }
                        $col-=1
                }        
                #else {$grid[$row][$col] = "X"}

            }
        }        
        elseif ($moving -eq "left") {
            if ($letter -eq "L") {
                $moving = "down"
            } else {$moving = "up"}
            $num=0
            while ($num -lt $mathNumber) {
                $num++
                if ($break) {break}
                $col-=1
                $start = [int]$col

                if ($data[$row][$col] -eq "#") {
                    $col+=1
                    break
                }        
                elseif ($data[$row][$col] -eq " ") {
                    $num--
                    $col = $data[$row].length-1
                    while ($data[$row][$col] -ne ".") {
                        $col-=1
                        if ($data[$row][$col] -eq "#") {$col = [int]$start + 0; $break = $true; break}
                    }
                        $col+=1
                }        
                #else {$grid[$row][$col] = "X"}
            }
        }
        elseif ($moving -eq "down") {
            if ($letter -eq "L") {
                $moving = "right"
            } else {$moving = "left"}
            $num=0
            while ($num -lt $mathNumber) {
                $num++
                if ($break) {break}
                $row+=1
                $start = [int]$row
                if ($data[$row][$col] -eq "#") {
                    $row-=1
                    break
                }
                elseif ($data[$row][$col] -eq " ") {
                    $num--
                    $row = 0
                    while ($data[$row][$col] -ne ".") {
                        $row+=1
                        if ($data[$row][$col] -eq "#") {$row = [int]$start + 0; $break = $true; break}
                    }
                        $row-=1
                }
                #else {$grid[$row][$col] = "X"}
                }
        }        
        elseif ($moving -eq "up") {
            if ($letter -eq "L") {
                $moving = "left"
            } else {$moving = "right"}
            $num=0
            while ($num -lt $mathNumber) {
                $num++
                if ($break) {break}
                $row-=1
                $start = [int]$row
                if ($data[$row][$col] -eq "#") {
                    $row+=1
                    break
                }        
                elseif ($data[$row][$col] -eq " ") {
                    $num--
                    $row = $data.Length-1
                    while ($data[$row][$col] -ne ".") {
                        $row-=1
                        if ($data[$row][$col] -eq "#") {$row = [int]$start + 0; $break = $true; break}
                    }
                        $row+=1
                }
                #else {$grid[$row][$col] = "X"}
            }
        }        
    }
    else {
        $number+= $letter
    }
}
#
#$grid[1][51] = "X"
#$grid[$row][$col] = "X"
#$grid | % {$_ -join ''}

$answer = (($row)* 1000) + (($col) * 4) 
$finalmovingcheck = @{right=0;down=1;left=2;up=3}
$answer += $finalmovingcheck[$finalmoving]
write-host "Answer 1 = $answer"


#Re-initialize grid, since we're starting over.
#i can't think of a way for both to be in the same loop, as this one resets the movement direction based on location
# the first run just continues in the same direction until it hits a wall.
$grid = $data.Clone()
$number = ""
$direction = "right"
$col = 51
$row = 1

:masterLoop for ($i=0; $i -lt ($moves.Length); $i++) {
    #if ($i -eq 90) {break}
    Write-Progress -Activity "Working" -PercentComplete ($I / $moves.Length * 100)
    $letter = $moves[$i]

    $finalmoving = $direction
    if ($letter -eq "L" -or $letter -eq "R" -and $direction -ne $olddirection) {
    #uncomment for debugging
    #    "i'm headed $direction, with $number moves, and i am at $row, $col, and I will turn $letter" 
    }

    if ("LR" -match $letter) {
        [int]$mathNumber = [int]$number
        $number = ""
    


        if ($direction -eq "right") {
            $olddirection = "right"
            if ($letter -eq "L") {
                $direction = "up"
            } else {
                $direction = "down"
            }
            $num=0
            while ($num -lt $mathNumber) {
                $num++

                $start = @([int]$row, [int]$col)
                $col+=1
                if ($data[$row][$col] -eq "#") {
                    $col-=1
                    break
                }        
                elseif ($data[$row][$col] -eq " ") {
                    $num--
                    $row, $col, $newdirection = get-new-pos $row $col $olddirection
                    if ($data[$row][$col] -eq "#") {

                        $row, $col = $start
                        break
                    }
                    else {
                        $direction = $newdirection
                        $Number = $mathNumber - $num - 1
                        $i--
                        continue masterLoop
                    }
                }        
                #else {$grid[$row][$col] = "X"}

            }
        }        
        elseif ($direction -eq "left") {
                $olddirection = "left"
            if ($letter -eq "L") {
                $direction = "down"
            } else {
                $direction = "up"
            }
            $num=0
            while ($num -lt $mathNumber) {
                $num++

                $start = @([int]$row, [int]$col)
                $col-=1
                if ($data[$row][$col] -eq "#") {
                    $col+=1
                    break
                }        
                elseif ($data[$row][$col] -eq " ") {
                    $num--
                    $row, $col, $newdirection = get-new-pos $row $col $olddirection
                    if ($data[$row][$col] -eq "#") {
                        $row, $col = $start
                        break
                    }
                    else {
                        $direction = $newdirection
                        $Number = $mathNumber - $num - 1
                        $i--
                        continue masterLoop
                    }
                }        
                #else {$grid[$row][$col] = "X"}
            }
        }
        elseif ($direction -eq "down") {
                $olddirection = "down"
            if ($letter -eq "L") {
                $direction = "right"
            } else {
                $direction = "left"
            }
            $num=0
            while ($num -lt $mathNumber) {
                $num++

                $start = @([int]$row, [int]$col)
                $row+=1
                if ($data[$row][$col] -eq "#") {
                    $row-=1
                    break
                }
                elseif ($data[$row][$col] -eq " ") {
                    $num--
                    $row, $col, $newdirection = get-new-pos $row $col $olddirection
                    if ($data[$row][$col] -eq "#") {
                        $row, $col = $start
                        break
                    }
                    else {
                        $direction = $newdirection
                        $Number = $mathNumber - $num - 1
                        $i--
                        continue masterLoop
                    }
                }        
                #else {$grid[$row][$col] = "X"}
                }
        }        
        elseif ($direction -eq "up") {
            $olddirection = "up"
            if ($letter -eq "L") {
                $direction = "left"
            } else {
                $direction = "right"
            }
            $num=0
            while ($num -lt $mathNumber) {
                $num++

                $start = @([int]$row, [int]$col)
                $row-=1
                if ($data[$row][$col] -eq "#") {
                    $row+=1
                    break
                }
                elseif ($data[$row][$col] -eq " ") {
                    $num--
                    $row, $col, $newdirection = get-new-pos $row $col $olddirection
                    if ($data[$row][$col] -eq "#") {
                        $row, $col = $start
                        break
                    }
                    else {
                        $direction = $newdirection
                        $Number = [string]($mathNumber - $num - 1)
                        $i--
                        continue masterLoop
                    }
                }        
                #else {$grid[$row][$col] = "X"}
            }
        }        
    }

    else {
        $number+= $letter
    }
}
#uncomment for debugging, this will add first and last X's
#$grid[1][51] = "X"
#$grid[$row][$col] = "X"
#$grid | % {$_ -join ''}

$answer = (($row)* 1000) + (($col) * 4) 
$finalmovingcheck = @{right=0;down=1;left=2;up=3}
$answer += $finalmovingcheck[$finalmoving]
Write-Host "Answer 2 = $answer"

} | select @{N="Milliseconds to Calculate";E={$_.TotalMilliseconds}}