class windows::java {

  dsc_xremotefile {'Download WebContent Zip':
    dsc_destinationpath => 'c:\larktemp\jdk-8u231-windows-x64.exe',
    dsc_uri             => 'https://s3.amazonaws.com/weslson.com/jdk-8u231-windows-x64.exe',
  }

}
