# http://blog.dbsnet.fr/disable-netbios-with-powershell

$key = "HKLM:SYSTEM\CurrentControlSet\services\NetBT\Parameters\Interfaces"

Get-ChildItem $key |
  foreach { 
    $NetbiosOptions_Value = (Get-ItemProperty "$key\$($_.pschildname)").NetbiosOptions
    If ($NetbiosOptions_Value -ne 2) {
      Write-Host("Modify $key\$($_.pschildname)")
      Write-Host("NetbiosOptions updated value is $NetbiosOptions_Value")
      exit 1;
    }
    #Write-Host("NetbiosOptions updated value is $NetbiosOptions_Value")
}
