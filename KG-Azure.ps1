function Set-KGLocation {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory)][string]$MyUser
    )
    
    begin {
        #$user = "allan.ross.sa@kongsberggeospatial.com"
        #$password = Get-Content D:\WindowsPowerShell\arsa.txt | ConvertTo-SecureString
        #$credential = new-object -TypeName System.Management.Automation.PSCredential -ArgumentList $user, $password
        #Connect-AzureAD -Credential $credential
    }
    
    process {
        # $ThisUser = Get-AzureADUser -ObjectId $MyUser

        Set-AzureADUser -ObjectId $MyUser -UsageLocation 'CA'
        Get-AzureADUser -ObjectId $MyUser|Select Displayname, UsageLocation
    }
    
    end {
        
    }
}
