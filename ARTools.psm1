#Collection of Active Directory tools

#Create a text file and store a password as a secure string
#this can them be used to create secure credentials for scripts/functions, etc
 
function Set-SecurePass {
    [CmdletBinding()]
    param (
        [securestring]$password,
        [string]$Path
    )
     
    process {
        $Path = Read-Host -Prompt "Where would you like to store this? (enter a full path and file name)"
        Read-Host -AsSecureString -Prompt "Enter a password"| ConvertFrom-SecureString| out-file $path
        Write-Host "Password has been securely stored in $path"
    }
    
}
