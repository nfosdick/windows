class windows {
  class{ 'windows::directories':
    require => Exec[ 'Enable WinRM' ],
  }

  class{ 'windows::registry':
    require => Exec[ 'Enable WinRM' ],
  }
  
  # https://lark-it.atlassian.net/browse/FCB-159
  # https://support.microsoft.com/en-us/help/974504/the-windows-remote-manager-winrm-service-does-not-start-after-you-unin
  exec { 'Enable WinRM':
    command    => 'winrm qc -quiet; Exit 0',
    unless    => 'if(winrm enumerate winrm/config/listener|Select-String 5985){ exit 0 }else{ exit 1 }',  
    path      => ['c:/windows/system32'],
    provider  => powershell,
  }

  $vm_tools_dir='c:\temp\VM-Tools'
  exec { "Remove ${vm_tools_dir} Folder":
    command  => "Remove-Item –path ${vm_tools_dir} -force -recurse",
    onlyif   => "if(Test-Path ${vm_tools_dir}){ exit 0 }else{ exit 1 }",
    provider => powershell,
  }
}
