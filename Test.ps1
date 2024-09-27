$mainfolder = Get-ChildItem 'C:\Users\NAME\Documents\Prüfanweisungen\' | where { $_.PsIsContainer -eq $true } #Grabs only Folders from the main folder and ignores files
foreach ($folder in $mainfolder) {
        $articlefolder = $folder | Where-Object {$_.Name -notlike 'Archive'}  				#Specifies that folders which do not have a folder named "Archive" in them arent counted as article folders that need to be worked on
        $anweisungpath = 'C:\Users\NAME\Documents\Prüfanweisungen\' + $articlefolder 			#The above specified Article folders path is turned into a Variable for easier use
        if ($articlefolder) {                                                				#If the check that Archive is missing is true
	        $prüfanweisung = Get-ChildItem $anweisungpath | Sort-Object -Property LastWriteTime 	#Files from the Article folder are sorted by their Last Write Time
	        foreach ($file in $prüfanweisung) {
			        $writetime = $file.LastWriteTime                                   	#1
			        $writedate = $writetime.ToString('yyyyMMdd')                       	#2 The Last Write Time is formated
			        $path = $file.DirectoryName + '\' + 'Archive' + '\' + $writedate       	#Defining a path to the currently not existing archive folder and the date folders in which the files will go
			        Write-Host $path
			        if ( -not($file.PSIsContainer)) {                      			#If an object isnt a folder...
				        if( -not(Test-Path $path)) {                        			#If the in line 10 created folder doesnt exist yet....
					        New-Item -Path $path -ItemType Directory         			#...then a folder is created...
                            			move-item $file.PSPath $path                     			#...and the files are moved into this folder. (This step is important, i forgot about it and it skipped moving the first file for each day)
				        }else {                                             		#If the object folder does exit...
					        move-item $file.PSPath $path                     		#...move all the files into their respective folders.
				        }
			        }
             }
        }
}
