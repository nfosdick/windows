$nic_list = (Get-WmiObject win32_networkadapterconfiguration | where{$_.IPEnabled -eq 1})
  foreach ($nic in $nic_list){$nic.SetTcpipNetbios(2)}
