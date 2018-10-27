## Required Modules

```powershell
Install-Module operationvalidation
Install-Module poshspec
Install-Module Pester
```

## Correction

line 234 of file **"C:\Program Files\WindowsPowerShell\Modules\OperationValidation\1.2.0\Public\Get-OperationValidation.ps1"**

```powershell
#Instead of
if ($PSVersionTable.PSVersion -ge 5)

#Should be
if ($PSVersionTable.PSVersion.Major -ge 5)
```

## Create OVF module

the psm1 file is optional. If a psm1 file is created an optional function can be created which can then be run as part of a scheduled task or job
place the module in $env:PSModulePath

## Running tests form the module as a module

```powershell
Invoke-OperationValidation -ModuleName $modulename -TestType simple
```

## Running tests form the module as a function

```powershell
#Import the custom OVF module with tests
Import-Module 'OVF.Demo-1'
Invoke-OVFDemo1
```
