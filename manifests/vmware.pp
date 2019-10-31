class windows::vmware {
  $source_dir='c:\larktemp\VMWare Tools'
  $vm_tools_dir='c:\temp\VM-Tools'
 
  # https://lark-it.atlassian.net/browse/FCB-152
  exec { 'Copy VMware Tools to C:\Temp':
    command  => "Copy-Item -Path \"${source_dir}\" -Destination \"${vm_tools_dir}\" -Recurse",
    provider => powershell,
  }   

  # https://lark-it.atlassian.net/browse/FCB-153
  exec { 'Install VMware Tools':
    command     => "${vm_tools_dir}\setup64.exe /S /v\"/qn REBOOT=R\"",
    provider    => powershell,
    subscribe   => Exec[ 'Copy VMware Tools to C:\Temp' ],
    refreshonly => true,
  }

  # https://lark-it.atlassian.net/browse/FCB-155
  exec { "Remove ${vm_tools_dir} Folder":
    command  => "Remove-Item –path ${vm_tools_dir} -force -recurse",
    onlyif   => "if(Test-Path ${vm_tools_dir}){ exit 0 }else{ exit 1 }",
    provider => powershell,
    require  => Exec[ 'Install VMware Tools' ],
  }
}
