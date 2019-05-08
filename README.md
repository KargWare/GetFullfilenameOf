# GetFullfilenameOf
Powershell (PS1) scripts, which search for exe-binaries on a Windows operation systems.

*Optional*: Add set the found path as environment variable for VSTS, TFS or DevOps Server build system.

# References

## Build and Release Variables on VSTS, TFS or Azure DevOps
[MSDN - Custom Variables](https://docs.microsoft.com/en-us/azure/devops/pipelines/release/variables?view=azure-devops&tabs=powershell)

Set the value ```crushed tomatoes``` to the variable named ```sauce``` in Powershell as VSTS, TFS or Azure DevOps variable.  
The parameter ```issecret=true``` mark the variable as secret.
```powershell
Write-Host "##vso[task.setvariable variable=sauce]crushed tomatoes"
Write-Host "##vso[task.setvariable variable=secret.Sauce;issecret=true]crushed tomatoes"
```