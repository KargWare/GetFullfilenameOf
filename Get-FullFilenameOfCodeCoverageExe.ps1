[CmdletBinding()]
param (
    [Parameter(Mandatory = $false)]
    [bool] $CheckCurrentDirectory = $false
)

$arrProgramFilesFolders = ( ${env:ProgramFiles}, ${env:ProgramFiles(x86)} )

$arrAppCert = @();
if($CheckCurrentDirectory) {
    $arrAppCert += "CodeCoverage.exe"
}
foreach ($folder in $arrProgramFilesFolders) {
    $arrAppCert += "$folder\Microsoft Visual Studio\2017\Enterprise\Team Tools\Dynamic Code Coverage Tools\CodeCoverage.exe"
    $arrAppCert += "$folder\Microsoft Visual Studio 14.0\Team Tools\Dynamic Code Coverage Tools\CodeCoverage.exe"
}    

foreach ($exeFile in $arrAppCert)
{
    if (Test-Path $exeFile) 
    { 
        Write-Host ("##vso[task.setvariable variable=FullFilenameOfCodeCoverageExe;]$exeFile")
        Write-Host "CodeCoverage.exe was found here: [ $exeFile ] and set as env variable 'FullFilenameOfCodeCoverageExe'" -ForegroundColor Green
        return
    }
}

Write-Host "CodeCoverage.exe not found. Please install Visual Studio and try again." -ForegroundColor Red
throw [System.IO.FileNotFoundException] "CodeCoverage.exe not found!"

