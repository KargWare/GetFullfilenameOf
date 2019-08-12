# [CmdletBinding()]
# param (
#     [Parameter(Mandatory = $true)]
#     [string[]] $functions,

#     [Parameter(Mandatory = $false)]
#     [bool] $checkTestExists = $true,
#     [Parameter(Mandatory = $false)]
#     [bool] $checkHelpBlock = $true,
#     [Parameter(Mandatory = $false)]
#     [bool] $checkAdvancedFunction = $true
# )

$functions = (
    'Get-FullFilenameOfAppCertExe',
    'Get-FullFilenameOfCertUtilExe',
    'Get-FullFilenameOfCodeCoverageExe',
    'Get-FullFilenameOfMakeCertExe',
    'Get-FullFilenameOfMSBuildExe',
    'Get-FullFilenameOfSignToolExe'
)

$checkTestExists = $false;
$checkHelpBlock = $true;
$checkAdvancedFunction = $true;

Describe "Function Checks" {
    
    # Check if ps1 files are available for each function
    Context "PS1-file with the function exists" {
        foreach ($function in $functions) {        
            It "$function.ps1 should exist" {
                "$naPath\$function.ps1" | Should Exist
            }
        }
    }

    # Check if the function has valid powershell code
    Context "Validation of Powershell code" {
        foreach ($function in $functions) {
        It "Check if $function.ps1 is valid PowerShell code" {
                $psFile = Get-Content -Path "$naPath\$function.ps1" `
                                    -ErrorAction Stop
                $errors = $null
                $null = [System.Management.Automation.PSParser]::Tokenize($psFile, [ref]$errors)
                $errors.Count | Should Be 0
            }
        }
    }

    # Check if Tests ffiles are available for each function
    if ($checkTestExists) {
        Context "Tests.PS1-file exists" {
            foreach ($function in $functions) {            
                It "$function.Tests.ps1 should exist" {
                    "$naPath\$function.Tests.ps1" | Should Exist
                }
            }
        }
    }

    # Check if the function have a well designed help block
    if ($checkHelpBlock) {
        Context "Validation thats functions have a well designed help block" {
            foreach ($function in $functions) {
                It "$function.ps1 should have a SYNOPSIS section in the help block" {
                    "$naPath\$function.ps1" | Should FileContentMatch '.SYNOPSIS'
                }
            
                It "$function.ps1 should have a DESCRIPTION section in the help block" {
                    "$naPath\$function.ps1" | Should FileContentMatch '.DESCRIPTION'
                }
            
                It "$function.ps1 should have a EXAMPLE section in the help block" {
                    "$naPath\$function.ps1" | Should FileContentMatch '.EXAMPLE'
                }
            }
        }
    }

    # Check if the function is an advanced function
    if ($checkAdvancedFunction) {
        Context "Validation that functions are Advanced Functions" {        
            foreach ($function in $functions) {
                It "$function.ps1 should be an advanced function" {                 
                    "$naPath\$function.ps1" | Should FileContentMatch 'function'
                    "$naPath\$function.ps1" | Should FileContentMatch '[CmdletBinding()]'
                    "$naPath\$function.ps1" | Should FileContentMatch 'param'
                }
            }
        }
    }

}