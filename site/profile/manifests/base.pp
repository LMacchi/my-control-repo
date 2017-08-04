# @summary This profile configures /etc/hosts and RSA keys
class profile::base {

  # Collect all vagrant sshkeys!

  if $facts['ssh'] {
    $vagrantrsakey = $::facts['ssh']['rsa']['key']

    @@sshkey { "${::fqdn}-rsa":
      ensure       => present,
      host_aliases => [$facts['hostname'],$vagrantip],
      key          => $vagrantrsakey,
      type         => 'ssh-rsa',
      tag          => 'vagranthost',
    }

    Sshkey <<| tag == 'vagranthost' |>>
  }
  
  # Ensure Vagrant/CentOS users have sudo access
  sudo::conf { 'Wheel':
    ensure  => 'present',
    content => '%wheel    ALL=(ALL)       NOPASSWD: ALL',
  }
  
  include vim
  vim::vim_profile { 'root': }
  
  include git
  
  git::config { 'user.name':
    value => 'Laura Macchi',
  }

  git::config { 'user.email':
    value => 'lm@puppet.com',
  }

}
