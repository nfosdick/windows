class windows::cis_security {

  # https://lark-it.atlassian.net/browse/FCB-165
  dsc_registry {'deny_ts_connection':
    dsc_ensure    => 'Present',
    dsc_key       => 'HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\services\eventlog\Security',
    dsc_valuename => 'MaxSize',
    dsc_valuedata => '84000',
    dsc_valuetype => 'Dword',
    dsc_force     => true,
  }
}
