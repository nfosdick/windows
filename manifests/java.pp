class windows::java(
  $destination_path = 'c:\larktemp',
  $install_version  = '8u231',
  $architecture     = $facts['architecture'],
){

  dsc_xremotefile {'Download WebContent Zip':
    dsc_destinationpath => "${destination_path}\jdk-${install_version}-windows-x${architecture}.exe',
    dsc_uri             => "https://s3.amazonaws.com/weslson.com/jdk-${install_version}-windows-x${architecture}.exe",
  }

}
