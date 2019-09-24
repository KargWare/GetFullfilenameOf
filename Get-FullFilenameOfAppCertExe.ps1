<#
  .SYNOPSIS
  Find AppcCert.exe in a list of known-locations or in the current folder as fullpath
  
  .DESCRIPTION
  Find AppcCert.exe in a list of known-locations or in the current folder as fullpath
  
  .INPUTS
  CheckCurrentDirectory = Should the current directory included in the search
    
  .OUTPUTS
  Fullpath of AppCenter.exe
  
  .EXAMPLE
  $exeFile = Get-FullFilenameOfAppCertExe

  .EXAMPLE
  $exeFile = Get-FullFilenameOfAppCertExe -CheckCurrentDirectory $true
#>

function Get-FullFilenameOfAppCertExe()
{
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
            return $exeFile
        }
    }

    Write-Host "AppCert.exe not found. Check Windows 10 SDK needed - https://go.microsoft.com/fwlink/p/?LinkID=822845 to get a SDK" -ForegroundColor Red
    throw [System.IO.FileNotFoundException] "AppCert.exe not found!"
    return ""
}

#Get-FullFilenameOfAppCertExe -CheckCurrentDirectory $true