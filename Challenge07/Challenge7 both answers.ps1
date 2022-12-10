#LOAD FILE
$linuxstructure = cat C:\Tools\advent2022\challenge7.txt

#SET SOME DEFAULT BLANK VARIABLES
$currentfolder= $null
$currentfolder = @('/')
$folders=@{}
$selffolders=@{}

#MAIN LOOP TO READ INPUT FILE
foreach ($layer in $linuxstructure) {
    #CHECK IF LINE STARTS WITH CD BASICALLY
    if ($layer -match '^\$\ cd.*') {
        #IF IT IS $ cd / THEN RESET FOLDER PATH (NOT NECESSARY IN THIS CHALLENGE)
        if ($layer -eq '$ cd /') {
            $currentfolder = @('/')
            $currentfolder.count
        } 
        #IF IT DOESN'T CONTAIN 2 .'S BUT IS A CD, THEN WE ADD THE LAYER DEPTH
        elseif ($layer -notmatch '\.\.') {
            #SPLIT LINE AND GRAB JUST FOLDER NAME
            $currentfolder += $layer.split(' ')[-1]
        }
        #IF IT DOES CONTAIN 2 .'S GO UP A FOLDER
        elseif ($layer -match '\.\.') {
            # REMOVE LAST FOLDER BY TAKING LENGTH OF FOLDER ARRAY
            # AND JUST COUNTING FROM 0 TO LENGHT MINUS 2
            $currentfolder = $currentfolder[0..($currentfolder.count -2)] 
        }
    }
    # IF IT STARTS WITH NUMBER, IT'S A VIABLE NUMBER TO ADD TO FOLDER SIZE
    elseif ($layer -match '^[0-9]'){        
        #CLIMB UP FOLDERS AND ADD SIZE TO EACH FOLDER AT CURRENT LAYER AND ABOVE
        foreach ($number in (0..($currentfolder.count-1))) {
            $folders[(($currentfolder)[0..$number] -join '')] += [int]($layer.split(' ')[0])
        }


    }
    
}
$sum = 0
$answer = @()

#GET EVERY FOLDER SORTED FOR NO REASON, BUT COULD BE USED
foreach ($folder in $folders.GetEnumerator()| sort name -Descending | select -ExpandProperty name) {
        ### IF LESS THAN 100000 WE CAN USE IT IN SUM.
        ### REMOVE NEXT LINE COMMENT IF YOU DON'T WANT TO INCLUDE SUB FOLDERS
    if ($folders[$folder] -le 100000){ #-and !($answer -match $folder)) {
        $sum += $folders[$folder]
    }
}

#PRINT ANSWER FOR SUMS
"Answer 1 = " + $sum
#PRINT SECOND ANSWER. GET 70,000K AND REMOVE SIZE OF / FROM IT (I JUST HARD SET IT)
#THEN TAKE 30,000K AND SUBTRACT PREVIOUS TOTAL GETTING MINIMUM SIZE NEEDED, THEN JUST SELECT THE FIRST COMPLIANT ITEM
"Answer 2 = " + ($folders.GetEnumerator() | where value -ge (30000000 - (70000000 - 46876531)) | sort value | select -First 1 -ExpandProperty value)

