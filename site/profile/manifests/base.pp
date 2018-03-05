# @summary This profile configures /etc/hosts
class profile::base {

  if $trusted['extensions']['pp_role'] {
    $line  = "PS1='\$USER@${trusted['extensions']['pp_role']} \$PWD> '"
    $alias = $trusted['extensions']['pp_role']
  } else {
    $line = "PS1='\$USER@${facts['fqdn']} \$PWD> '"
    $alias = $facts['hostname']
  }
  
  if $facts['external_ip'] {
    @@host { $facts['fqdn']:
      ensure       => present,
      host_aliases => $alias,
      ip           => $facts['external_ip'],
      tag          => 'ext',
    }
  
    Host <<| tag == 'ext' |>>
    
  } else {
    @@host { $facts['fqdn']:
      ensure       => present,
      host_aliases => $alias,
      ip           => $facts['ipaddress'],
      tag          => 'int',
    }
  
    Host <<| tag == 'int' |>>
    
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

  file_line { 'bashrc_friendly_name':
    path => '/root/.bashrc',
    line => $line,
  }

  package { 'tree':
    ensure => present,
  }

}
