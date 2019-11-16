$interface  = 'HKLM:\SYSTEM\CurrentControlSet\Services\netbt\Parameters\interfaces'
  Get-ChildItem $i | ForEach-Object {
  Get-ItemProperty -Path "$i\$($_.pschildname)" -name NetBiosOptions | where{$_.NetBiosOptions -ne 2}
}
