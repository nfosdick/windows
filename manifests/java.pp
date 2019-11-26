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

  # https://stackoverflow.com/questions/18890926/how-to-get-the-java-version-in-powershell
  # https://github.com/counsyl/puppet-windows/blob/master/manifests/java.pp
  # https://puppet.com/docs/puppet/5.5/resources_package_windows.html
  # https://skarlso.github.io/2015/06/30/powershell-can-also-be-nice-or-installing-java-silently-and-waiting/
  # https://puppet.com/docs/puppet/latest/type.html#package
  # https://stackoverflow.com/questions/24430141/downloading-jdk-using-powershell
  # https://github.com/cyberious/puppet-windows_java/blob/master/manifests/jdk.pp
  exec { "Install jdk-${install_version}-windows-${architecture}.exe":
    command  => "Start-Process -FilePath ${destination_path}/jdk-${install_version}-windows-${architecture}.exe -ArgumentList '/s' -Wait",
    unless   => 'if(Get-Command java | Select-Object Version|Select-String 8.0.2310.11){ exit 0 }else{ exit 1 }',
    #unless   => 'Get-Command java | Select-Object Version|Select-String 8.0.2310.11',
    provider => powershell,
  }
}
