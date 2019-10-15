class setup_os {

  # https://lark-it.atlassian.net/browse/FCB-138
  dsc_registry {'deny_ts_connection':
    dsc_ensure    => 'Present',
    dsc_key       => 'HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Terminal Server',
    dsc_valuename => 'DenyTSConnection',
    dsc_valuedata => '0',
    dsc_valuetype => 'Dword',
    dsc_force     => true,
  }

  # https://lark-it.atlassian.net/browse/FCB-158
  dsc_registry {'Disable Multicast':
    dsc_ensure    => 'Present',
    dsc_key       => 'HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters',
    dsc_valuename => 'IGMPLevel',
    dsc_valuetype => 'Dword',
    dsc_valuedata => '0',
  }

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
}
