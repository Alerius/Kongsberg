#Prompt to enter users LAN ID
$readADUser = Read-Host "Please enter a username to terminate"

#Display current user groups
Get-ADUser $readADUser -Properties memberof | select -expand memberof | sort

#Prompt for new password for term'd user
$newPassword = (Read-Host -Prompt "Provide New Password" -AsSecureString)
Set-ADAccountPassword -Identity $readADUser -NewPassword $newPassword -Reset

#Add user to TermedUsersGroup in AD and set as primary
$ADGroup = get-adgroup "TERMEDUSERSADGROUPNAME" -properties @("primaryGroupToken")
Add-ADGroupMember -Identity $ADGroup -Members $readADUser
get-aduser $readADUser | set-aduser -replace @{primaryGroupID=$ADGroup.primaryGroupToken}

#Find all group memberships and remove them except TermedUsersGroup and move to TerminatedUsers OU in AD
Get-ADPrincipalGroupMembership -Identity $readADUser | where {$_.Name -notlike "TermedUsersGroup"} | % {Remove-ADPrincipalGroupMembership -Identity $readADUser -MemberOf $_ -Confirm:$false}
Get-ADUser $readADUser | Move-ADObject -TargetPath 'OU=TERMEDUSERSOU,DC=YOURDOMAINNAMEHERE,DC=local' -Confirm:$false
Remove-ADPrincipalGroupMembership -Identity $readADUser -MemberOf "Domain Users" -Confirm:$false