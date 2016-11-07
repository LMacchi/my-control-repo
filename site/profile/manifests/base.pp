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

  # Collect all vagrant sshkeys!

  $vagrantrsakey = $::ssh['rsa']['key']

  @@sshkey { $::fqdn:
    ensure       => present,
    host_aliases => [$::hostname,$::ipaddress],
    key          => $vagrantrsakey,
    type         => 'ssh-rsa',
    tag          => ['vagranthost'],
  }

  Sshkey <<| tag == 'vagranthost' |>>

}
