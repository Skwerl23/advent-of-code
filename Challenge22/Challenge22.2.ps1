$data = cat C:\Tools\advent2022\Challenge22a.txt 
#uncomment the else statements for a trail of X's, it does eventually break the script
# but it is very useful for trail hunting. 

###no test data as the cube shapes are different

$grid = @()
$grid += ,([char[]]" "*152)
foreach ($row in $data[0..($data.Length-2)]) {
    $grid+= ,([char[]](" " + $row + (" "*(150 - $row.length ) + " ")))    
}
#$grid += ,([char[]]" "*200)

$moves = $data[-1] + "L"

$data = $grid.clone()


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

    if ($letter -eq "L") {
        [int]$mathNumber = [int]$number
        $number = ""
    


        if ($direction -eq "right") {
            $olddirection = "right"
            $direction = "up"

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
            $direction = "down"
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
            $direction = "right"
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
                $direction = "left"
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
    elseif ($letter -eq "R") {

    [int]$mathNumber = [int]$number
        $number = ""
#        "I am moving $mathNumber $direction and then turning right"
        if ($direction -eq "right") {
            $olddirection = "right"
            $direction = "down"
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
            $direction = "up"
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
            $direction = "left"
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
            $direction = "right"
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
                    $Number = $mathNumber - $num - 1
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
$answer