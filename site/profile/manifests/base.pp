# @summary This profile configures /etc/hosts and RSA keys
class profile::base {

  # Collect all vagrant hosts!
  # Discard vbox internal ip
  if $facts['ipaddress'] == '10.0.2.15' {
    $vagrantip = $facts['networking']['interfaces']['eth1']['ip']
  } else {
    $vagrantip = $facts['ipaddress']
  }

  @@host { $facts['fqdn']:
    ensure       => present,
    host_aliases => [$facts['hostname']],
    ip           => $vagrantip,
    tag          => 'vagranthost',
  }

  Host <<| tag == 'vagranthost' |>>

  # Collect all vagrant sshkeys!

  $vagrantrsakey = $::ssh['rsa']['key']

  @@sshkey { "${::fqdn}-rsa":
    ensure       => present,
    host_aliases => [$facts['hostname'],$vagrantip],
    key          => $vagrantrsakey,
    type         => 'ssh-rsa',
    tag          => 'vagranthost',
  }

  Sshkey <<| tag == 'vagranthost' |>>

  # Ensure Vagrant/CentOS users have sudo access
  sudo::conf { 'Wheel':
    ensure  => 'present',
    content => '%wheel    ALL=(ALL)       NOPASSWD: ALL',
  }

}
