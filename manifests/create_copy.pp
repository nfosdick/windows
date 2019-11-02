class windows::create_copy(
  $logoutput = 'on_failure',
){
  # https://lark-it.atlassian.net/browse/FCB-141
  $pcw_source_dir      = 'c:/larktemp/VMWare Tools'
  $pcw_destination_dir = 'c:/PCW'
  dsc_file {'PCW Directory':
    dsc_ensure          => 'present',
    dsc_type            => 'Directory',
    dsc_destinationpath => $pcw_source_dir,
  }

  # https://lark-it.atlassian.net/browse/FCB-142
  exec { 'Copy PCW':
    command   => "Copy-Item -Path \"${pcw_source_dir}\" -Destination \"${pcw_destination_dir}\" -Recurse -Force",
    provider  => powershell,
    logoutput => $logoutput,
    require   => Dsc_file[ 'PCW Directory' ],
    # onlyif or unless "if(command to run if to check if PCW tools is installed){ exit 0 }else{ exit 1 }",
    # onlyif or unless will be needed to check to see if PCW tools is installed already here.
    # I don't have source files here
  }

  # https://lark-it.atlassian.net/browse/FCB-150
  dsc_file {'Temp Directory':
    dsc_ensure          => 'present',
    dsc_type            => 'Directory',
    dsc_destinationpath => 'c:\\Temp',
  }

  #https://lark-it.atlassian.net/browse/FCB-143
  $toolbox_source_dir      = 'c:/larktemp/VMWare Tools'
  $toolbox_destination_dir = 'c:/Toolbox'
  dsc_file {'Toolbox Directory':
    dsc_ensure          => 'present',
    dsc_type            => 'Directory',
    dsc_destinationpath => $toolbox_destination_dir,
  }

  # https://lark-it.atlassian.net/browse/FCB-144
  exec { 'Copy Toolbox':
    command   => "Copy-Item -Path \"${toolbox_source_dir}\" -Destination \"${toolbox_destination_dir}\" -Recurse -Force",
    provider  => powershell,
    logoutput => $logoutput,
    require   => Dsc_file[ 'Toolbox Directory' ],
    # onlyif or unless "if(command to run if to check if toolbox tools is installed){ exit 0 }else{ exit 1 }",
    # onlyif or unless will be needed to check to see if toolbox tools is installed already here.
    # I don't have source files here
  }

  # https://lark-it.atlassian.net/browse/FCB-145
  $powershell_source_dir      = 'c:/larktemp/VMWare Tools'
  $powershell_destination_dir = "${toolbox_destination_dir}/powershellscripts"
  dsc_file {'poswershellscripts Directory':
    dsc_ensure          => 'present',
    dsc_type            => 'Directory',
    dsc_destinationpath => $powershell_destination_dir,
    require             => Dsc_file[ 'Toolbox Directory' ],
  }

  exec { 'Copy powershellscripts':
    command   => "Copy-Item -Path \"${powershell_source_dir}\" -Destination \"${powershell_destination_dir}\" -Recurse -Force",
    provider  => powershell,
    logoutput => $logoutput,
    require   => Dsc_file[ 'sowershellscripts Directory' ],
    # onlyif or unless "if(command to run if to check if powershellscript are already installed){ exit 0 }else{ exit 1 }",
    # I don't have source files here
  }

  # https://lark-it.atlassian.net/browse/FCB-149
  dsc_file {'InstallLogs Directory':
    dsc_ensure          => 'present',
    dsc_type            => 'Directory',
    dsc_destinationpath => 'c:\\InstallLogs',
  }
}
