class windows::java(
  $destination_path = 'c:/larktemp',
  $install_version  = '8u231',
  $architecture     = $facts['architecture'],
){

  dsc_xremotefile {'Download WebContent Zip':
    dsc_destinationpath => "${destination_path}/jdk-${install_version}-windows-${architecture}.exe",
#    dsc_destinationpath => 'c:\larktemp\jdk-8u231-windows-x64.exe',
    dsc_uri             => 'https://s3.amazonaws.com/weslson.com/jdk-8u231-windows-x64.exe',
    #dsc_uri             => "https://s3.amazonaws.com/weslson.com/jdk-${install_version}-windows-x${architecture}.exe",
  }

}
