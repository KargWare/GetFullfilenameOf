$naPath = Split-Path $MyInvocation.MyCommand.Path -Parent
Set-Location $naPath
Write-Host "The Working Directory is '$naPath'."

Import-Module Pester

# Invoke-Pester "$naPath\DoExampleTests.Tests.ps1"
# Invoke-Pester "$naPath\DoExampleTests.Tests.ps1" -Tag 'Unit'
# Invoke-Pester "$naPath\DoExampleTests.Tests.ps1" -Tag 'Integration'
# Invoke-Pester "$naPath\DoExampleTests.Tests.ps1" -Tag 'Acceptance'

# Invoke-Pester "$naPath\DoAllScriptsHaveATestFile.Tests.ps1"
# Invoke-Pester "$naPath\DoAllScriptsHaveATestFile.Tests.ps1" -Strict
$TestResults = Invoke-Pester "$naPath\DoAllScriptsHaveATestFile.Tests.ps1" -PassThru
Write-Host $TestResults.PassedCount;

# # Tests and export results as NUnit
# New-Item -ItemType directory -Path "$naPath\TestResults"
# Invoke-Pester "$naPath\DoAllScriptsHaveATestFile.Tests.ps1" `
#     -OutputFile "$naPath\TestResults\nunit.xml" `
#     -OutputFormat NUnitXml

# # Code Coverage
# Invoke-Pester "$naPath\DoAllScriptsHaveATestFile.Tests.ps1" `
#     -CodeCoverage "$naPath\DoAllScriptsHaveATestFile.Tests.ps1"
