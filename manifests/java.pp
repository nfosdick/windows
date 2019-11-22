class windows::java(
  $url              = 'https://s3.amazonaws.com/weslson.com',
  $destination_path = 'c:/larktemp',
  $install_version  = '8u231',
  $architecture     = $facts['architecture'],
){

  dsc_xremotefile {"Download jdk-${install_version}-windows-${architecture}.exe":
    dsc_destinationpath => "${destination_path}/jdk-${install_version}-windows-${architecture}.exe",
    dsc_uri             => "${url}/jdk-${install_version}-windows-${architecture}.exe",
  }

#  package { "jdk-${install_version}-windows-${architecture}.exe":
#    ensure          => installed,
#    ensure          => '8.0.2310.11',
#    source          => "${destination_path}/jdk-${install_version}-windows-${architecture}.exe",
#    install_options => ['/s'],
#    provider        => windows,
#    require         => Dsc_xremotefile[ "Download jdk-${install_version}-windows-${architecture}.exe" ],
#  }

  exec { "Install jdk-${install_version}-windows-${architecture}.exe":
    command  => "${destination_path}/jdk-${install_version}-windows-${architecture}.exe",
    unless   => 'if(Get-Command java | Select-Object Version|Select-String 8.0.2310.11){ exit 0 }else{ exit 1 }',
    provider => powershell,
  }
}
