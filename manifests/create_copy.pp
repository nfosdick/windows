class windows::create_copy(
  $logoutput = 'on_failure',
){
  # https://lark-it.atlassian.net/browse/FCB-141
  $pcw_source_dir      = 'c:/larktemp/'
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

  # https://lark-it.atlassian.net/browse/FCB-164
  exec { 'Run SEO Config Script':
    command   => "${pcw_destination_dir}/pcw-set.cmd"
    provider  => powershell,
    logoutput => $logoutput,
    require   => Exec[ 'Copy PCW' ],
    # onlyif or unless "if(command to run if to check if command has already been run){ exit 0 }else{ exit 1 }",
    # Typically there is some flag here to tell if this has been run successfully
    # I don't have source files here
  }

  # https://lark-it.atlassian.net/browse/FCB-150
  dsc_file {'Temp Directory':
    dsc_ensure          => 'present',
    dsc_type            => 'Directory',
    dsc_destinationpath => 'c:/Temp',
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
  dsc_file {'powershellscripts Directory':
    dsc_ensure          => 'present',
    dsc_type            => 'Directory',
    dsc_destinationpath => $powershell_destination_dir,
    require             => Dsc_file[ 'Toolbox Directory' ],
  }

  # https://lark-it.atlassian.net/browse/FCB-146
  exec { 'Copy powershellscripts':
    command   => "Copy-Item -Path \"${powershell_source_dir}\" -Destination \"${powershell_destination_dir}\" -Recurse -Force",
    provider  => powershell,
    logoutput => $logoutput,
    require   => Dsc_file[ 'powershellscripts Directory' ],
    # onlyif or unless "if(command to run if to check if powershellscript are already installed){ exit 0 }else{ exit 1 }",
    # I don't have source files here
  }

  # https://lark-it.atlassian.net/browse/FCB-149
  dsc_file {'InstallLogs Directory':
    dsc_ensure          => 'present',
    dsc_type            => 'Directory',
    dsc_destinationpath => 'c:/InstallLogs',
  }

  # https://lark-it.atlassian.net/browse/FCB-147
  $install_source_dir      = 'c:/larktemp'
  $install_destination_dir = 'c:/Install'
  dsc_file {'Install Directory':
    dsc_ensure          => 'present',
    dsc_type            => 'Directory',
    dsc_destinationpath => $install_destination_dir,
  }

  # https://lark-it.atlassian.net/browse/FCB-148
  exec { 'Copy Install':
    command   => "Copy-Item -Path \"${install_source_dir}\" -Destination \"${install_destination_dir}\" -Recurse -Force",
    provider  => powershell,
    logoutput => $logoutput,
    require   => Dsc_file[ 'Install Directory' ],
    # onlyif or unless "if(command to run if to check if Install files already installed){ exit 0 }else{ exit 1 }",
    # I don't have source files here
  }

  # https://lark-it.atlassian.net/browse/FCB-151
  $infosec_file            = 'InfoSec64.cmd'
  $infosec_source_dir      = "${install_destination_dir}/scripts/${infosec_file}"
  exec { "Copy ${infosec_file}":
    command   => "Copy-Item -Path \"${infosec_source_dir}\" -Destination \"c:/windows/security/${infosec_file}\" -Force",
    provider  => powershell,
    logoutput => $logoutput,
    unless    => "if(Test-Path c:/windows/security/${infosec_file}}){ exit 0 }else{ exit 1 }",
    require   => Exec[ 'Copy Install' ],
  }

}