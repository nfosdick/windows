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

  # reg add HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\DateTime\Servers /t REG_SZ /d 6 /f
  dsc_registry {'W32Time Default':
    dsc_ensure    => 'Present',
    dsc_key       => 'HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\DateTime\Servers',
    dsc_valuename => '',
    dsc_valuedata => '6',
    dsc_force     => true,
  }

  # reg add HKLM\SYSTEM\CurrentControlSet\Control\TimeZoneInformation /v ActiveTimeBias /t REG_DWORD /d 0xf0 /f
  dsc_registry {'TimeZoneInformation ActiveTimeBias':
    dsc_ensure    => 'Present',
    dsc_hex       => true,
    dsc_key       => 'HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\TimeZoneInformation',
    dsc_valuename => 'ActiveTimeBias',
    dsc_valuedata => '0xf0',
    dsc_valuetype => 'Dword',
    dsc_force     => true,
  }

  # reg add HKLM\SYSTEM\CurrentControlSet\Control\TimeZoneInformation /v Bias /t REG_DWORD /d 0x12c /f
  dsc_registry {'TimeZoneInformation Bias':
    dsc_ensure    => 'Present',
    dsc_hex       => true,
    dsc_key       => 'HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\TimeZoneInformation',
    dsc_valuename => 'Bias',
    dsc_valuedata => '0x12c',
    dsc_valuetype => 'Dword',
    dsc_force     => true,
  }

  # reg add HKLM\SYSTEM\CurrentControlSet\Control\TimeZoneInformation /v DayLightBias /t REG_DWORD /d 0xffffffc4 /f
  dsc_registry {'TimeZoneInformation DayLightBias':
    dsc_ensure    => 'Present',
    dsc_hex       => true,
    dsc_key       => 'HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\TimeZoneInformation',
    dsc_valuename => 'DayLightBias',
    dsc_valuedata => '0xffffffc4',
    dsc_valuetype => 'Dword',
    dsc_force     => true,
  }
}
