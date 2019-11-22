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

  package { "jdk-${install_version}-windows-${architecture}.exe":
    ensure          => installed,
    source          => "${destination_path}/jdk-${install_version}-windows-${architecture}.exe",
    install_options => ['/s'],
    require         => Dsc_xremotefile[ "Download jdk-${install_version}-windows-${architecture}.exe" ],
  }

}
