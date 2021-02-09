function Open-ARSession {
    [CmdletBinding()]
    param ([string]$computer)
    
    begin {
        $user = "allan.ross.sa"
        $password = Get-Content c:\_DATA\WindowsPowerShell\arsa.txt | ConvertTo-SecureString
        $credential = new-object -TypeName System.Management.Automation.PSCredential -ArgumentList $user, $password
    }
    
    process {
        $session = New-PSSession -Credential $credential -ComputerName $computer
        Enter-PSSession $session
    }
    
    end { }
}
function Close-ARSession {
    [CmdletBinding()]
    param ([string]$computer)
    
    begin { }
    
    process {
        Exit-PSSession
        Remove-PSSession -ComputerName $computer
    }
    
    end { }
}
