<#
  .SYNOPSIS
  Find MSBuild.exe in a list of known-locations or in the current folder as fullpath
  
  .DESCRIPTION
  Find MSBuild.exe in a list of known-locations or in the current folder as fullpath
  
  .INPUTS
  CheckCurrentDirectory = Should the current directory included in the search
    
  .OUTPUTS
  Fullpath of MSBuild.exe
  
  .EXAMPLE
  $exeFile = Get-FullFilenameOfAppCertExe

  .EXAMPLE
  $exeFile = Get-FullFilenameOfAppCertExe -CheckCurrentDirectory $true 
#>

function Get-FullFilenameOfMSBuildExe()
{
    [CmdletBinding()]
    param (
        [Parameter(Mandatory = $false)]
        [bool] $CheckCurrentDirectory = $false
    )

    $arrProgramFilesFolders = ( ${env:ProgramFiles}, ${env:ProgramFiles(x86)} )

    $arrMsBuild = @();
    if($CheckCurrentDirectory) {
        $arrMsBuild += "msbuild.exe"
    }
    foreach ($folder in $arrProgramFilesFolders) {
        $arrMsBuild += "$folder\Microsoft Visual Studio\2019\Enterprise\MSBuild\Current\Bin\MSBuild.exe"
        $arrMsBuild += "$folder\Microsoft Visual Studio\2017\Enterprise\MSBuild\15.0\Bin\msbuild.exe"        
    }    

    foreach ($exeFile in $arrMsBuild)
    {
        if (Test-Path $exeFile) 
        { 
            Write-Host ("##vso[task.setvariable variable=FullFilenameOfMsBuildExe;]$exeFile")
            Write-Host "MsBuild.exe was found here: [ $exeFile ] and set as env variable 'FullFilenameOfMsBuildExe'" -ForegroundColor Green
            return $exeFile
        }
    }

    Write-Host "MsBuild.exe not found." -ForegroundColor Red
    throw [System.IO.FileNotFoundException] "MsBuild.exe not found!"
    return ""
}

#Get-FullFilenameOfMSBuildExe -CheckCurrentDirectory $true