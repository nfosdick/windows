class windows::create_copy {
  # https://lark-it.atlassian.net/browse/FCB-141
  $pcw_source_dir      = 'c:/larktemp/VMWare Tools',
  $pcw_destination_dir = 'c:/PCW',
  dsc_file {'PCW Directory':
    dsc_ensure          => 'present',
    dsc_type            => 'Directory',
    dsc_destinationpath => $pcw_source_dir,
  }

  # https://lark-it.atlassian.net/browse/FCB-142
  exec { 'Copy VMware Tools to C:\Temp':
    command   => "Copy-Item -Path \"${pcw_source_dir}\" -Destination \"${$pcw_destination_dir}\" -Recurse -Force",
    provider  => powershell,
    logoutput => $logoutput,
    require   => File[ 'PCW Directory' ],
    # onlyif or unless "if(command to run if to check if vmware tools is installed){ exit 0 }else{ exit 1 }",
    #onlyif or unless will be needed to check to see if vmware tools is installed already here.
    #The azure vm would not let me install vmware tools as it wasn't a vmware vm.
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
