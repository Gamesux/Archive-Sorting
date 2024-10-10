A Powershell Script i made for work, and with an actual usecase too and not just to learn/practice/kill time. It took me a good bit to figure out, aka driving me crazy. 

We have a main folder, this folder contains subfolders with Article numbers. Inside of those "Article folders" are loose files. 
The point of the script is to give each "Article folder" in the main folder an Archive folder and then create dated folders to move the loose files into.
This script is going to be set to run once a week to clean up any new files. Its also supposed to work dynamically so that if a new article is created inside the Main folder, the script will take it into consideration automatically.
