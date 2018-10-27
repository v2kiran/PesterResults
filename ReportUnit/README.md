## Download RepotUnit

https://www.nuget.org/packages/ReportUnit/

## Run pester tests and Output to xml

```powershell
Invoke-Pester  -OutputFormat NUnitXml -OutputFile output.xml
```

## Generate HTML output using reportunit.exe

```powershell
$runit = "C:\Users\kiran\OneDrive\Apps\pester\ReportUnit.exe"
&$runit .\output.xml
```
