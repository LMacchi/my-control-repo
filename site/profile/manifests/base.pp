class profile::base {

  # Collect all vagrant hosts!
  $vagrantip = $::networking['interfaces']['eth1']['ip']

  @@host { $::fqdn:
    ensure       => present,
    host_aliases => [$::hostname],
    ip           => $vagrantip,
    tag          => ['vagranthost'],
  }

  Host <<| tag == 'vagranthost' |>>

}
