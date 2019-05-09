[CmdletBinding()]
param (
    [Parameter(Mandatory = $false)]
    [bool] $CheckCurrentDirectory = $false
)

$arrProgramFilesFolders = ( ${env:ProgramFiles}, ${env:ProgramFiles(x86)} )

$arrAppCert = @();
if($CheckCurrentDirectory) {
    $arrAppCert += "appcert.exe"
}
foreach ($folder in $arrProgramFilesFolders) {
    $arrAppCert += "$folder\Windows Kits\10\App Certification Kit\appcert.exe"
    $arrAppCert += "$folder\Windows Kits\8.1\App Certification Kit\appcert.exe"
    $arrAppCert += "$folder\Windows Kits\8.0\App Certification Kit\appcert.exe"
}    

foreach ($exeFile in $arrAppCert)
{
    if (Test-Path $exeFile) 
    { 
        Write-Host ("##vso[task.setvariable variable=FullFilenameOfAppCertExe;]$exeFile")
        Write-Host "AppCert.exe was found here: [ $exeFile ] and set as env variable 'FullFilenameOfAppCertExe'" -ForegroundColor Green
        return
    }
}

Write-Host "AppCert.exe not found. Check Windows 10 SDK needed - https://go.microsoft.com/fwlink/p/?LinkID=822845 to get a SDK" -ForegroundColor Red
throw [System.IO.FileNotFoundException] "AppCert.exe not found!"

