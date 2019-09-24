<#
  .SYNOPSIS
  Find CertUtil.exe in a list of known-locations or in the current folder as fullpath
  
  .DESCRIPTION
  Find CertUtil.exe in a list of known-locations or in the current folder as fullpath
  
  .INPUTS
  CheckCurrentDirectory = Should the current directory included in the search
    
  .OUTPUTS
  Fullpath of CertUtil.exe
  
  .EXAMPLE
  $exeFile = Get-FullFilenameOfAppCertExe

  .EXAMPLE
  $exeFile = Get-FullFilenameOfAppCertExe -CheckCurrentDirectory $true
#>

function Get-FullFilenameOfCertUtilExe()
{
    [CmdletBinding()]
    param (
        [Parameter(Mandatory = $false)]
        [bool] $CheckCurrentDirectory = $false
    )

    $arrCertUtil = @();
    if($CheckCurrentDirectory) {
        $arrCertUtil += "certutil.exe"
    }
    $arrCertUtil += "C:\Windows\SysWOW64\certutil.exe"
    $arrCertUtil += "C:\Windows\System32\certutil.exe"

    foreach ($exeFile in $arrCertUtil)
    {
        if (Test-Path $exeFile) 
        { 
            Write-Host ("##vso[task.setvariable variable=FullFilenameOfCertUtilExe;]$exeFile")
            Write-Host "CertUtil.exe was found here: [ $exeFile ] and set as env variable 'FullFilenameOfCertUtilExe'" -ForegroundColor Green
            return $exeFile
        }
    }

    Write-Host "CertUtil.exe not found." -ForegroundColor Red
    throw [System.IO.FileNotFoundException] "CertUtil.exe not found!"
    return ""
}

#Get-FullFilenameOfCertUtilExe -CheckCurrentDirectory $true