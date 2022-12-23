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
    if ($letter -eq "L") {
        [int]$mathNumber = [int]$number
        $number = ""
        #uncomment for debugging
        #"I am moving $mathNumber $moving and then turning left"
    
        $break = $false

        if ($moving -eq "right") {
            $moving = "up"

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
            $moving = "down"
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
            $moving = "right"
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
                $moving = "left"
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
    elseif ($letter -eq "R") {
        $break = $false

    [int]$mathNumber = [int]$number
        $number = ""
        if ($moving -eq "right") {
            $moving = "down"
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
                        if ($data[$row][$col] -eq "#") {$col = [int]$start + 0; $break = $true; break}
 
                    }
                        $col-=1
                }
                #else {$grid[$row][$col] = "X"}
}
        }        
        elseif ($moving -eq "left") {
            $moving = "up"
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
            $moving = "left"
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
            $moving = "right"
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
                $row = $data.length-1
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
$answer