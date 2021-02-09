Function Disable-MyUser {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory)][string[]]$MyUser
    )

    begin {
        $user="Administrator"
        $password=Get-Content D:\TEMP\AdminPass.txt |ConvertTo-SecureString
        $credential=new-object -TypeName System.Management.Automation.PSCredential -ArgumentList $user, $password

        $MyQuery = @{
            Server = "diomedes"
            Credential = $credential
            SearchBase = "OU=Gallium Users & Groups,DC=gallium,DC=soft"
        }
    }
    process {
        $ThisUser = Get-ADUser -Identity $MyUser @MyQuery
        write-host $ThisUser.enabled 

    }
    

    end {
        
    }

}
Disable-MyUser