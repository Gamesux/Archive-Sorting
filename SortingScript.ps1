$oberordner = Get-ChildItem 'C:\Users\meow\Documents\Prüfanweisungen\' | where { $_.PsIsContainer -eq $true }
foreach ($folder in $oberordner) {
        $artikelordner = $folder 
        $anweisungpath = 'C:\Users\meow\Documents\Prüfanweisungen\' + $artikelordner + '\' + "*"
        if (Test-Path $artikelordner) {
	        $prüfanweisung = Get-ChildItem -Path $anweisungpath -Include *.dfq | where { $_.PsIsContainer -eq $false } | Sort-Object -Property LastWriteTime
	        foreach ($file in $prüfanweisung) {
			        $writetime = $file.LastWriteTime                    #1
			        $writedate = $writetime.ToString("yyyy-MM")         #2 Last Write Time is formatted from the long full Format to yyyy-MM
			        $path = $file.DirectoryName + "\" + $writedate      #Path variable is created which consists of the directory of where the file is alongside the writedate formatted variable.
			        Write-Host $path
				    if( -not(Test-Path $path)) {                       	#If the Path described in line 10 doesnt exist...
					    New-Item -Path $path -ItemType Directory          #...then it will create a new Directory in that path
                        move-item $file.PSPath $path            #afterwards all files that match the date of the folder will be moved into it.
				    }else {                                             #If the Path described in line 10 does exist...
					    move-item $file.PSPath $path                      #...move all files into their matching Directory.
				    }
             }
        }
}
#Script should run at the 1st of each Month, to clean up all the files created within the previous month
