class windows::cis_security {

  # https://lark-it.atlassian.net/browse/FCB-165
  # Reg add HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Service\eventlog\Security /v MaxSize /t REG_DWORD /d 0xc840000 /f
  dsc_registry {'Security MaxSize':
    dsc_ensure    => 'Present',
    dsc_key       => 'HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\services\eventlog\Security',
    dsc_valuename => 'MaxSize',
    dsc_valuedata => '84000',
    dsc_valuetype => 'Dword',
    dsc_force     => true,
  }

  dsc_registry {'Security Retention':
    dsc_ensure    => 'Present',
    dsc_key       => 'HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\services\eventlog\Security',
    dsc_valuename => 'Retention',
    dsc_valuedata => '0',
    dsc_valuetype => 'Dword',
    dsc_force     => true,
  }

  dsc_registry {'Security AutoBackupLogFiles':
    dsc_ensure    => 'Present',
    dsc_key       => 'HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\services\eventlog\Security',
    dsc_valuename => 'AutoBackupLogFiles',
    dsc_valuedata => '0',
    dsc_valuetype => 'Dword',
    dsc_force     => true,
  }

  dsc_registry {'System MaxSize':
    dsc_ensure    => 'Present',
    dsc_key       => 'HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\services\eventlog\System',
    dsc_valuename => 'MaxSize',
    dsc_valuedata => '84000',
    dsc_valuetype => 'Dword',
    dsc_force     => true,
  }

  dsc_registry {'System Retention':
    dsc_ensure    => 'Present',
    dsc_key       => 'HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\services\eventlog\System',
    dsc_valuename => 'Retention',
    dsc_valuedata => '0',
    dsc_valuetype => 'Dword',
    dsc_force     => true,
  }

  dsc_registry {'System AutoBackupLogFiles':
    dsc_ensure    => 'Present',
    dsc_key       => 'HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\services\eventlog\System',
    dsc_valuename => 'AutoBackupLogFiles',
    dsc_valuedata => '0',
    dsc_valuetype => 'Dword',
    dsc_force     => true,
  }

  # reg add HKLM\SYSTEM\CurrentControlSet\services\Tcpip6\Parameters /v DisabledComponents /t REG_DWORD /d 0xffffffff
  # Bug: https://github.com/PowerShell/xPSDesiredStateConfiguration/issues/332
  # https://github.com/puppetlabs/puppetlabs-dsc/blob/master/lib/puppet/type/dsc_registry.rb
  dsc_registry {'Tcpip6 DisabledComponents':
    dsc_ensure    => 'Present',
    dsc_key       => 'HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\services\Tcpip6\Parameters',
    dsc_hex       => true,
    dsc_valuename => 'DisabledComponents',
    dsc_valuedata => 'ffffffff',
    dsc_valuetype => 'Dword',
    dsc_force     => true,
  }

  # reg add HKLM\SYSTEM\CurrentControlSet\services\W32Time /v start /t REG_DWORD /d 2 /f
  dsc_registry {'W32Time Start':
    dsc_ensure    => 'Present',
    dsc_key       => 'HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\services\W32Time',
    dsc_valuename => 'start',
    dsc_valuedata => '2',
    dsc_valuetype => 'Dword',
    dsc_force     => true,
  }

  #  reg add HKLM\SYSTEM\CurrentControlSet\services\W32Time\Parameter /v NtpServer /t REG_SZ /d ntp.1.aaa.com,0x9 /f
  $ntp_server = 'ntp.1.aaa.com'
  dsc_registry {'W32Time NtpServer':
    dsc_ensure    => 'Present',
    dsc_key       => 'HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\services\W32Time\Parameters',
    dsc_valuename => 'NtpServer',
    dsc_valuedata => "${ntp_server},0x9",
    dsc_force     => true,
  }

  # reg add HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\DateTime\Servers /v 6 /t REG_SZ /d ntp.1.aaa.com /f
  dsc_registry {'W32Time 6':
    dsc_ensure    => 'Present',
    dsc_key       => 'HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\DateTime\Servers',
    dsc_valuename => '6',
    dsc_valuedata => "${ntp_server}",
    dsc_force     => true,
  }


}
