Describe -Name 'Simple Validation of PSGallery' {
    It 'The PowerShell Gallery should be responsive' {
        $response = Invoke-WebRequest -Uri 'https://www.powershellgallery.com/' -UseBasicParsing
        $response.StatusCode | Should be 200
    }
}


Describe 'Folders' {
    it 'Temp folder exists on C root' { 
        Test-Path C:\temp | should be $true
    }
}

Describe 'Services' {
    it 'BITS service should be running' {
        (Get-Service BITS).status |  should be 'Running'
    }
  
}