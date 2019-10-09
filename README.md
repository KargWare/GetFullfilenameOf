# GetFullFilenameOf

__TOC__

Powershell (PS1) scripts, which search for exe-binaries on a Windows operation systems.

The scripts will be available as Powershell Module `GetFullFilenameOf` on the [Powershell Gallery](https://www.powershellgallery.com/).

*Optional*: Add set the found path as environment variable for VSTS, TFS or DevOps Server build system.

## Scripts

All the scripts search on system folders to find the binary. For the Programfiles the scripts cover 32-bit and 64-bit. Additional can the Parameter ```CheckCurrentDirectory``` be set to ```$true```, the the current folder will be included in the serach. Default Value is ```$false```.  

|Binary|Scripts|Variable|
|------|-------|--------|
|AppCert.exe|[Get-FullFilenameOfAppCertExe.ps1](./Get-FullFilenameOfAppCertExe.ps1)|FullFilenameOfAppCertExe|
|CertUtil.exe|[Get-FullFilenameOfCertUtilExe.ps1](./Get-FullFilenameOfCertUtilExe.ps1)|FullFilenameOfCertUtilExe|
|CodeCoverage.exe|[Get-FullFilenameOfCodeCoverageExe.ps1](./Get-FullFilenameOfCodeCoverageExe.ps1)|FullFilenameOfCodeCoverageExe|
|SignTool.exe|[Get-FullFilenameOfSignToolExe.ps1](./Get-FullFilenameOfSignToolExe.ps1)|FullFilenameOfSignToolExe|

## Modules

[Microsoft Docs: Create PS1-Module](https://docs.microsoft.com/en-us/powershell/developer/module/how-to-write-a-powershell-module-manifest)
[Writing Help for PowerShell Modules](https://docs.microsoft.com/en-us/powershell/developer/module/writing-help-for-windows-powershell-modules)

```powershell
New-ModuleManifest GetFullFilenameOf.psd1
Test-ModuleManifest GetFullFilenameOf.psd1
Import-Module GetFullFilenameOf.psd1
```

[Microsoft Docs: Publish PS1-Module](https://docs.microsoft.com/en-us/powershell/module/powershellget/publish-module?view=powershell-6)

```powershell
Publish-Module -Name "GetFullFilenameOf" -NuGetApiKey "xxxxxxxx-yyyy-yyyy-yyyy-xxxxxxxxxxxx"
```

## Tests

[Pester](https://github.com/pester/Pester) is used to run the Powershell tests.

PluralSight [01](file:///D:/Pluralsight/Testing%20PowerShell%20with%20Pester/powershell-testing-pester/01/introduction-to-unit-testing-slides.pdf)

Types of Testing

* Unit Tests - Tests a single function or method, independent from all other tests
* Integration Tests - Test the combination of tests. Maybe some environment is needed
* Acceptance Tests - Happy Day or Edge Case Tests, can also be driven by a reported bug

Install the Test Infrastructure (PackageManagement, Pester and list the commands of pester)

```powershell
$PSVersionTable
Import-Module PackageManagement
Install-Module Pester -Force
Get-Command -Module Pester
Get-Module Pester | Select Version
Get-Module Pester | Select Version -ExpandProperty Version
Get-Module Pester | Select Version | Format-Table -HideTableHeaders
```

## Environment Variables

Environment variables can have the scope `machine`, `user` and `process`.  

### Environment Variables on Powershell

Set the value of an environment variable `MyEnvVar` on an elevated Powershell (System-wide)

```powershell
[System.Environment]::SetEnvironmentVariable('MyEnvVar', 'My value with spaces', [System.EnvironmentVariableTarget]::Machine)
```

Set the value of an environment variable `MyEnvVar` on an Powershell (User-scope)

```powershell
[System.Environment]::SetEnvironmentVariable('MyEnvVar', 'My value with spaces', [System.EnvironmentVariableTarget]::User)
```

Show the value of an environment variable `MyEnvVar` on Powershell

```powershell
write-host ${Env:\MyEnvVar}
```

Delete an environment variable `MyEnvVar` on an elevated Powershell (System-wide)

```powershell
[System.Environment]::SetEnvironmentVariable('MyEnvVar', $null, [System.EnvironmentVariableTarget]::Machine)
```

Delete an environment variable `MyEnvVar` on Powershell (User-scope)

```powershell
[System.Environment]::SetEnvironmentVariable('MyEnvVar', $null, [System.EnvironmentVariableTarget]::User)
```

### Environment Variables on Terminal

**Hint** Be careful with `SETX`, it will truncate your variable value to 1024 chars! Very dangerous when manipulating e.g. %path%

Set the value of an environment variable `MyEnvVar` on an elevated Terminal (System-wide)

```cmd
setx /M MyEnvVar "My value with spaces"
```

Set the value of an environment variable `MyEnvVar` on an Terminal (User-scope)

```cmd
setx MyEnvVar "My value with spaces"
```

Show the value of an environment variable `MyEnvVar` on Terminal

```cmd
echo %MyEnvVar%
```

Delete an environment variable `MyEnvVar` on an elevated Terminal (System-wide)

```cmd
reg delete "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\Environment" /F /V MyEnvVar
```

Delete an environment variable `MyEnvVar` on Terminal (User-scope)

```cmd
reg delete "HKCU\Environment" /v MyEnvVar /f
```

## References

### Microsoft Tools 
[VSwhere](https://github.com/microsoft/vswhere/wiki/Examples)  

### Build and Release Variables on VSTS, TFS or Azure DevOps
[MSDN - Custom Variables](https://docs.microsoft.com/en-us/azure/devops/pipelines/release/variables?view=azure-devops&tabs=powershell)

Set the value ```crushed tomatoes``` to the variable named ```sauce``` in Powershell as VSTS, TFS or Azure DevOps variable.  
The parameter ```issecret=true``` mark the variable as secret.
```powershell
Write-Host "##vso[task.setvariable variable=sauce]crushed tomatoes"
Write-Host "##vso[task.setvariable variable=secret.Sauce;issecret=true]crushed tomatoes"
```
