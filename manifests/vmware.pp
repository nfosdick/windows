class windows::vmware {

  # https://lark-it.atlassian.net/browse/FCB-155
  $vm_tools_dir='c:\temp\VM-Tools'
  exec { "Remove ${vm_tools_dir} Folder":
    command  => "Remove-Item –path ${vm_tools_dir} -force -recurse",
    onlyif   => "if(Test-Path ${vm_tools_dir}){ exit 0 }else{ exit 1 }",
    provider => powershell,
  }
}
