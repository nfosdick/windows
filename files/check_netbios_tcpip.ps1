# http://blog.dbsnet.fr/disable-netbios-with-powershell

$key = "HKLM:SYSTEM\CurrentControlSet\services\NetBT\Parameters\Interfaces"

Get-ChildItem $key |
  foreach { 
    $NetbiosOptions_Value = (Get-ItemProperty "$key\$($_.pschildname)").NetbiosOptions
    Write-Host("NetbiosOptions updated value is $($_.pschildname) $NetbiosOptions_Value")
    If ($NetbiosOptions_Value -ne 2) {
      #exit 1;
      echo hello
    }
    #Write-Host("NetbiosOptions updated value is $NetbiosOptions_Value")
}
