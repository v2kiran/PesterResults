function Invoke-OVFDemo1
{
    [cmdletbinding()]
    param 
    (
        [String] 
        $LogName = 'Application',

        [String] 
        $EventSource = 'OVFDemo1',

        [Int] 
        $EventId = 10000,

        [ValidateSet('Simple', 'Comprehensive')]
        [String] 
        $TestType = 'Simple',

        [switch]
        $writeEventLog
    )


    if ($writeEventLog)
    {
        if ((Get-EventLog -List -AsString ) -notcontains $LogName)
        {
            New-EventLog -LogName $LogName -Source $EventSource 
        }
        # Add the Event Source if it doesn't exist
        if (-not [system.diagnostics.eventlog]::SourceExists($EventSource))
        {
            [system.diagnostics.EventLog]::CreateEventSource($EventSource, $LogName)
        } 
    }


    # Execute the tests
    $modulename = Split-Path -Path $PSScriptRoot -Leaf
    $Results = Invoke-OperationValidation -ModuleName $modulename -TestType $TestType 
    $FailedTests = $Results | Where-Object Result -EQ 'Failed'

    if ($writeEventLog)
    {
        # write each Failed test as a separate event to the Event Log
        foreach ($FailedTest in $FailedTests)
        {
            $writeEventLogSplat = @{
                Source    = $EventSource
                EntryType = 'Error'
                Category  = 0
                LogName   = $LogName
                Message   = $FailedTest.Name
                EventId   = $EventId
            }
            # write to log
            Write-EventLog  @writeEventLogSplat
            $EventId++
        } # foreach
    }
    else
    {
        $Results
    }

}

