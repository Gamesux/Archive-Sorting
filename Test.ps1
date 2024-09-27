$oberordner = Get-ChildItem 'C:\Users\jk440\Documents\Prüfanweisungen\' | where { $_.PsIsContainer -eq $true } #Bezieht nur Ordner aus dem "Prüfanweisungen" ordner
foreach ($folder in $oberordner) {
        $artikelordner = $folder | Where-Object {$_.Name -notlike 'Archiv'}  #Nur Ordner welche kein Objekt namens "Archiv" beinhalten werden in bezug genommen
        $anweisungpath = 'C:\Users\jk440\Documents\Prüfanweisungen\' + $artikelordner #Oben genannter Ordner wird als Variable zu einem einfacher benutzbaren Path
        if ($artikelordner) {                                                #Wenn die Anweisung, dass "Archiv" fehlt Wahr ist...
	        $prüfanweisung = Get-ChildItem $anweisungpath | Sort-Object -Property LastWriteTime #Dateien aus dem Artikelordner werden nach Write Date Sortiert
	        foreach ($file in $prüfanweisung) {
			        $writetime = $file.LastWriteTime                                   #1
			        $writedate = $writetime.ToString("yyyyMMdd")                       #2 Der LastWriteTime wird umformatier
			        $path = $file.DirectoryName + "\" + "Archiv" + "\" + $writedate       #Ein Pfad an den noch zu existierenden Datumordner wird erstellt
			        Write-Host $path
			        if ( -not($file.PSIsContainer)) {                      #Wenn ein Objekt kein ordner ist...
				        if( -not(Test-Path $path)) {                        #Wenn es den in Zeile 10 erstellten path noch nicht gibt....
					        New-Item -Path $path -ItemType Directory         #...wird er erstellt.
                            move-item $file.PSPath $path                     #und dann die Dateien in den Order verschoben.
				        }else {                                             #Wenn es das Objekt gibt...
					        move-item $file.PSPath $path                     #...verschiebt es die Dateien in die richtigen Ordner.
				        }
			        }
             }
        }
}