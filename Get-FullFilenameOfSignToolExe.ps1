[CmdletBinding()]
param (
    [Parameter(Mandatory = $false)]
    [bool] $CheckCurrentDirectory = $false
)

$arrProgramFilesFolders = ( ${env:ProgramFiles}, ${env:ProgramFiles(x86)} )

$arrSignTool = @();
if($CheckCurrentDirectory) {
    $arrSignTool += "signtool.exe"
}
foreach ($folder in $arrProgramFilesFolders) {
    $arrSignTool += "$folder\Windows Kits\10\bin\x64\signtool.exe"
    $arrSignTool += "$folder\Windows Kits\10\bin\x86\signtool.exe"
    $arrSignTool += "$folder\Windows Kits\8.1\bin\x64\signtool.exe"
    $arrSignTool += "$folder\Windows Kits\8.1\bin\x86\signtool.exe"
    $arrSignTool += "$folder\Windows Kits\8.0\bin\x64\signtool.exe"
    $arrSignTool += "$folder\Windows Kits\8.0\bin\x86\signtool.exe"
}    

foreach ($exeFile in $arrSignTool)
{
    if (Test-Path $exeFile) 
    { 
        Write-Host ("##vso[task.setvariable variable=FullFilenameOfSignToolExe;]$exeFile")
        Write-Host "SignTool.exe was found here: [ $exeFile ] and set as env variable 'FullFilenameOfSignToolExe'" -ForegroundColor Green
        return
    }
}

Write-Host "SignTool.exe not found. Check Windows 10 SDK needed - https://go.microsoft.com/fwlink/p/?LinkID=822845 to get a SDK" -ForegroundColor Red
throw [System.IO.FileNotFoundException] "SignTool.exe not found!"

