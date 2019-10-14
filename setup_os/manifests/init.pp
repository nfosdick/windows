class setup_os {
  dsc_registry {'deny_ts_connection':
    dsc_ensure => 'Present',
    dsc_key => 'HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Terminal Server',
    dsc_valuename => 'DenyTSConnection',
    dsc_valuedata => '0',
    dsc_valuetype => 'Dword',
    dsc_force     => true,
  }

  dsc_file {'PCW Directory':
    dsc_ensure          => 'present',
    dsc_type            => 'Directory',
    dsc_destinationpath => 'c:\\PCW',
  }
}
