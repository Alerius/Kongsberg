Function Disable-Gallium {
    [CmdletBinding()]
    param (
        [string]$MyComputer
    )

    begin {
        $user="allan.ross.sa"
        $password=Get-Content D:\WindowsPowerShell\arsa.txt |ConvertTo-SecureString
        $credential=new-object -TypeName System.Management.Automation.PSCredential -ArgumentList $user, $password

        $DisabledPath = "OU=MigratedComputers,DC=gallium,DC=soft"

        $MyQuery = @{
            Server = "diomedes"
            Credential = $credential
            SearchBase = "CN=Computers,DC=gallium,DC=soft"
        }
    }
    process {
        $ThisComputer = Get-ADComputer @MyQuery -Filter 'Name -like $MyComputer'
        Disable-ADAccount $ThisComputer
        $ThisComputer | Move-ADObject -TargetPath $DisabledPath
    }    
    end {
        

    }
}
# Disable-Gallium foo

function Test-Gallium {
    [CmdletBinding()]
    param ()
    
    begin {
        $user="Administrator"
        $password=Get-Content D:\TEMP\AdminPass.txt |ConvertTo-SecureString
        $credential=new-object -TypeName System.Management.Automation.PSCredential -ArgumentList $user, $password
    
        $MyQuery = @{
            Server = "diomedes"
            Credential = $credential
            SearchBase = "CN=Computers,DC=gallium,DC=soft"
            #SearchBase = "OU=WSUS Clients,DC=gallium,DC=soft"
            Filter = "*"
        }
    }
    
    process {
        $AllComputers=Get-ADComputer @MyQuery 
        ForEach ($computer in $AllComputers) {
            If (Test-Connection -computerName $computer.name -Count 2 -Quiet){
                # Write-Host -ForegroundColor Red "L I V E : " -NoNewline
                Write-host $computer.Name
            }
#                else {
#                    Write-Host -nonewline "dead:"
#                   Write-host $computer.Name
 #               }
        }
    }
    
    end {
    }
}
# Test-Gallium


