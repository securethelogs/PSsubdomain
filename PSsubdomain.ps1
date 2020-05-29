
$logo = @(  "",
"__________  _________           ___.        .___                    .__        ",
"\______   \/   _____/ ________ _\_ |__    __| _/____   _____ _____  |__| ____  ",
" |     ___/\_____  \ /  ___/  |  \ __ \  / __ |/  _ \ /     \\__  \ |  |/    \ ",
" |    |    /        \\___ \|  |  / \_\ \/ /_/ (  <_> )  Y Y  \/ __ \|  |   |  \",
" |____|   /_______  /____  >____/|___  /\____ |\____/|__|_|  (____  /__|___|  /",
"                  \/     \/          \/      \/            \/     \/        \/ ",
"",

"Creator: https://securethelogs.com / @securethelogs",
"")


$logo



# Temp File Location

$tempfile = "C:\Temp\dnsenum.txt"


# Prompt for domain

Write-Output ""

[string]$domain = Read-Host -Prompt "Please Enter You Domain"

# Scan Sites 

$virustotal = (curl https://www.virustotal.com/ui/domains/$domain/subdomains).content >> $tempfile 
$crt = (curl https://crt.sh/?q=%25.$domain).content >> $tempfile 


$arrayFromFile = @(Get-Content $tempfile)

# Delete temp file

Remove-Item –path $tempfile


Write-Output ""
Write-Output "Scanning..................... (May Contain Duplicates)"
Write-Output ""

foreach ($i in $arrayFromFile){

# ---------------- VirusTotal --------------------------

$VT = $i.Contains('"id":')

if ($VT -eq "True") {


#Remove fluff
$dnsfound = $i -replace '"id":',"" -replace '"',"" -replace ",","" -replace " ",""


#Print DNS Record
$dnsfound


} 



# ----------------- CRT Checking ------------------------

$test = $i.Contains("<B")

if ($test -eq "True"){

# Remove fluff
$result = $i -replace "<BR>","`n" -replace "<TD>","`n" -replace "</BR>","`n" -replace "</TD>","`n `n----------"


$result


}


}

Write-Output ""






