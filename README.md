# GetFullfilenameOf
Powershell (PS1) scripts, which search for exe-binaries on a Windows operation systems.

*Optional*: Add set the found path as environment variable for VSTS, TFS or DevOps Server build system.

# Scripts

All the scripts search on system folders to find the binary. For the Programfiles the scripts cover 32-bit and 64-bit. Additional can the Parameter ```CheckCurrentDirectory``` be set to ```$true```, the the current folder will be included in the serach. Default Value is ```$false```.  

|Binary|Scripts|Variable|
|------|-------|--------|
|signtool.exe|[Get-FullFilenameOfSignToolExe.ps1](./Get-FullFilenameOfSignToolExe.ps1)|FullFilenameOfSignToolExe|

# References

## Build and Release Variables on VSTS, TFS or Azure DevOps
[MSDN - Custom Variables](https://docs.microsoft.com/en-us/azure/devops/pipelines/release/variables?view=azure-devops&tabs=powershell)

Set the value ```crushed tomatoes``` to the variable named ```sauce``` in Powershell as VSTS, TFS or Azure DevOps variable.  
The parameter ```issecret=true``` mark the variable as secret.
```powershell
Write-Host "##vso[task.setvariable variable=sauce]crushed tomatoes"
Write-Host "##vso[task.setvariable variable=secret.Sauce;issecret=true]crushed tomatoes"
```