####### Edit these Variables
# Gets todays Date
$date = Get-Date

# Number of days it's been since the computer authenticated to the domain
$staleDate = [DateTime]::Today.AddDays(-90)

# Sets a description on that object so other admins know why the object was disabled
$description = "Disabled by IT Team on $date due to inactivity for 90 days."

# This is where the disabled accounts get moved to.
$disabledOU = "OU=disabled objects, OU=KGEO, DC=corp, DC=kongsberggeospatial, DC=com"

# path to the log file
$logpath = "c:\temp\Computers_90_Days_Old.csv"
####### Edit these Variables

# Finding Stale Computers
$params = @{
    Filter     = "*"
    SearchBase = "DC=corp,DC=kongsberggeospatial, DC=com"
    Properties = "LastLogonDate"
}

$findcomputers = Get-adcomputer @params | Where-Object { $_.enabled -eq $true -and $_.LastLogonDate -le $staleDate -and $_.lastlogondate -ne $null }

# Create a CSV containg all the Stale Computer Information
$findcomputers | ft Name, LastLogonDate | export-csv $logpath



#
# Remove the # below in order to run the actions
#


# Disable the Stale Computer Accounts
#$findcomputers | set-adcomputer -Description $description –passthru | Disable-ADAccount

# Find all the Stale Computer Accounts we just disabled
#$disabledAccounts = Search-ADAccount -AccountDisabled -ComputersOnly -SearchBase $ou

# Move the Disabled accounts to $disabledOU
#$disabledAccounts | Move-ADObject -TargetPath $disabledOU