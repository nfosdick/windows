class windows {
  class{ 'windows::directories':
    before => Exec[ 'Enable WinRM' ],
  }

  class{ 'windows::registry':
    before => Exec[ 'Enable WinRM' ],
  }
  
  # https://lark-it.atlassian.net/browse/FCB-159
  exec { 'Enable WinRM':
    command    => 'winrm qc -quiet; Exit 0',
    unless    => 'if(winrm enumerate winrm/config/listener|Select-String 5985){ exit 0 }else{ exit 1 }',  
    path      => ['c:/windows/system32'],
    provider  => powershell,
  }

}
