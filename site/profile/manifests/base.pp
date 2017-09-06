# @summary This profile configures /etc/hosts
class profile::base {
  
  @@host { $facts['fqdn']:
    ensure       => present,
    host_aliases => $trusted['extensions']['pp_role'],
    ip           => $facts['ipaddress'],
    tag          => 'puppet',
  }
  
  Host <<| tag == 'puppet' |>>
  
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
  
  if str2bool($trusted['extensions']['pp_role']) {
    $line = "PS1=\"\u@${trusted['extensions']['pp_role']} \t \w> \""
  } else {
    $line = "PS1=\"\u@${facter['fqdn']} \t \w> \""
  }
  
  file_line { 'bashrc_friendly_name':
    path => '/root/.bashrc',
    line => $line,
  }

}
