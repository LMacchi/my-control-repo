# @summary This profile configures /etc/hosts and RSA keys
class profile::base {

  # Collect all vagrant hosts!
  $vagrantip = $::networking['interfaces']['eth1']['ip']

  @@host { $::fqdn:
    ensure       => present,
    host_aliases => [$::hostname],
    ip           => $vagrantip,
    tag          => 'vagranthost',
  }

  Host <<| tag == 'vagranthost' |>>

  # Collect all vagrant sshkeys!

  $vagrantrsakey = $::ssh['rsa']['key']

  @@sshkey { "${::fqdn}-rsa":
    ensure       => present,
    host_aliases => [$::hostname,$vagrantip],
    key          => $vagrantrsakey,
    type         => 'ssh-rsa',
    tag          => 'vagranthost',
  }

  Sshkey <<| tag == 'vagranthost' |>>
  
}
