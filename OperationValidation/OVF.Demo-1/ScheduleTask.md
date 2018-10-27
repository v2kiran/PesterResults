## schedule the script to run every 60 minutes

```powershell
$Cred = Get-Credential -Message 'User to run task as'
$Action = New-ScheduledTaskAction `
    –Execute 'PowerShell.exe' `
    -Argument '-WindowStyle Hidden -Command "Import-Module ValidateDNS; Invoke-ValidateDNS;"'
$Trigger = New-ScheduledTaskTrigger `
    -Once `
    -At (Get-Date -Hour 0 -Minute 0 -Second 0) `
    -RepetitionInterval (New-TimeSpan -Minutes 60) `
    -RepetitionDuration ([System.TimeSpan]::MaxValue)
$Task = New-ScheduledTask `
    -Description 'Validate DNS' `
    -Action $Action `
    -Trigger $Trigger
Register-ScheduledTask `
    -TaskName 'Validate DNS' `
    -InputObject $Task `
    -User $Cred.UserName `
    -Password $Cred.GetNetworkCredential().Password
```
