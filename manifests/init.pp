class windows {
  # https://lark-it.atlassian.net/browse/FCB-141
  dsc_file {'PCW Directory':
    dsc_ensure          => 'present',
    dsc_type            => 'Directory',
    dsc_destinationpath => 'c:\\PCW',
  }

  # https://lark-it.atlassian.net/browse/FCB-150
  dsc_file {'Temp Directory':
    dsc_ensure          => 'present',
    dsc_type            => 'Directory',
    dsc_destinationpath => 'c:\\Temp',
  }

  #https://lark-it.atlassian.net/browse/FCB-143
  dsc_file {'Toolbox Directory':
    dsc_ensure          => 'present',
    dsc_type            => 'Directory',
    dsc_destinationpath => 'c:\\Toolbox',
  }

  # https://lark-it.atlassian.net/browse/FCB-145
  dsc_file {'Toolbox PowerShellScripts Directory':
    dsc_ensure          => 'present',
    dsc_type            => 'Directory',
    dsc_destinationpath => 'c:\\Toolbox\\PowerShellScripts',
    require             => Dsc_file[ 'Toolbox Directory' ],
  }

  # https://lark-it.atlassian.net/browse/FCB-149
  dsc_file {'InstallLogs Directory':
    dsc_ensure          => 'present',
    dsc_type            => 'Directory',
    dsc_destinationpath => 'c:\\InstallLogs',
  }

  # bcedit.exe /set {current} nx OptIn
  # https://lark-it.atlassian.net/browse/FCB-159
  exec { 'Enable WinRM':
    command    => 'winrm qc -quiet; Exit 0',
    unless    => 'if(winrm enumerate winrm/config/listener|Select-String 5985){ exit 0 }else{ exit 1 }',  
    path      => ['c:/windows/system32'],
    provider  => powershell,
  }

  class {'::windows::registry':
    require => Exec[ 'Enable WinRM' ],
  }

#dsc_service{'winrom':
#  dsc_ensure => present,
#  dsc_name   => 'winrm',
#  dsc_state  => 'running'
#}
}
