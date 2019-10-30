class windows {
  include windows::directories
  include windows::registry
  
  # https://lark-it.atlassian.net/browse/FCB-159
  exec { 'Enable WinRM':
    command    => 'winrm qc -quiet; Exit 0',
    unless    => 'if(winrm enumerate winrm/config/listener|Select-String 5985){ exit 0 }else{ exit 1 }',  
    path      => ['c:/windows/system32'],
    provider  => powershell,
  }

}
