<#
  .SYNOPSIS
  Find MakeCert.exe in a list of known-locations or in the current folder as fullpath
  
  .DESCRIPTION
  Find MakeCert.exe in a list of known-locations or in the current folder as fullpath
  
  .INPUTS
  CheckCurrentDirectory = Should the current directory included in the search
    
  .OUTPUTS
  Fullpath of MakeCert.exe
  
  .EXAMPLE
  $exeFile = Get-FullFilenameOfAppCertExe

  .EXAMPLE
  $exeFile = Get-FullFilenameOfAppCertExe -CheckCurrentDirectory $true
  
#>

function Get-FullFilenameOfMakeCertExe()
{
    [CmdletBinding()]
    param (
        [Parameter(Mandatory = $false)]
        [bool] $CheckCurrentDirectory = $false
    )

    $arrProgramFilesFolders = ( ${env:ProgramFiles}, ${env:ProgramFiles(x86)} )

    $arr = @();
    if($CheckCurrentDirectory) {
        $arr += "makecert.exe"
    }
    foreach ($folder in $arrProgramFilesFolders) {
        $arr += "$folder\Windows Kits\10\bin\x64\makecert.exe"
        $arr += "$folder\Windows Kits\10\bin\x86\makecert.exe"
        $arr += "$folder\Windows Kits\8.1\bin\x64\makecert.exe"
        $arr += "$folder\Windows Kits\8.1\bin\x86\makecert.exe"
        $arr += "$folder\Windows Kits\8.0\bin\x64\makecert.exe"
        $arr += "$folder\Windows Kits\8.0\bin\x86\makecert.exe"
    }    

    foreach ($exeFile in $arr)
    {
        if (Test-Path $exeFile) 
        { 
            Write-Host ("##vso[task.setvariable variable=FullFilenameOfMakeCertExe;]$exeFile")
            Write-Host "makecert.exe was found here: [ $exeFile ] and set as env variable 'FullFilenameOfMakeCertExe'" -ForegroundColor Green
            return $exeFile
        }
    }

    Write-Host "MakeCert.exe not found. Check Windows 10 SDK needed - https://go.microsoft.com/fwlink/p/?linkid=84091, see also https://docs.microsoft.com/en-us/windows/desktop/SecCrypto/makecert, to get a SDK" -ForegroundColor Red
    throw [System.IO.FileNotFoundException] "MakeCert.exe not found!"
    return ""
}