Add-Type -AssemblyName PresentationFramework

[xml]$Form = Get-Content "C:\_DATA\GitHub\KongsbergGUI\KongsbergGUI\CreateUser.xaml"
$NR = (New-Object System.Xml.XmlNodeReader $Form)
$win = [Windows.Markup.xamlreader]::Load( $NR )

$FirstName = $win.FindName("FirstName")
$Surname = $win.FindName("Surname")
$SamAccountName = $win.FindName("SamAccountName")
$CreateUser = $win.FindName("CreateUser")

$CreateUser.Add_Click( {
        $SamAccountName.text = ($FirstName.text + "." + $Surname.text).ToLower()
        $FirstName.Text = (Get-Culture).TextInfo.ToTitleCase($FirstName.text.ToLower())
        $Surname.Text = (Get-Culture).TextInfo.ToTitleCase($Surname.text.ToLower())
    })

$win.Showdialog()
