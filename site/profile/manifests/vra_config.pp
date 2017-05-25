# Configures the user that vRA uses to provision and purge nodes.
class profile::vra_config (
  $puppet_autosign_shared_secret = 'S3cr3tP@ssw0rd!',
)  {

# This user is just to work around the fact that openldap
# is what the system is bound to, but the web console is
# bound to AD.  Once the system has AD binding, remove
# this user locally.
  user { 'pe_vra_user':
      ensure           => 'present',
      gid              => '1001',
      home             => '/home/pe_vra_user',
      password         => '$6$rxdJrITS$yXlw8msHyTOC6a.pSqj8AdHabPazC.QEaSP2jQvtE.hXaZ1wZa7dzFwfclUe04gcq3MkBAIKHkQVs8RZ7F0QI.',
      password_max_age => '99999',
      password_min_age => '0',
      shell            => '/bin/bash',
      uid              => '1001',
      managehome       => true,
  }

# The vRA user needs to be able to sudo for puppet cert purge
# commands as well as restarting pe-puppetserver to clean up
# PuppetDB. The sudoers file locks access down for sudo.
  sudo::conf { 'pe_vra_user':
    priority => 60,
    content  => epp('profile/vra_config/pe_vra_user.epp'),
  }

# We also need to configure autosigning for vRA.
  file { '/etc/puppetlabs/puppet/autosign.rb' :
    ensure  => file,
    owner   => 'pe-puppet',
    group   => 'pe-puppet',
    mode    => '0700',
    content => template('profile/vra_config/autosign.rb.erb'),
    notify  => Service['pe-puppetserver'],
  }

  ini_setting { 'autosign script setting':
    ensure  => present,
    path    => '/etc/puppetlabs/puppet/puppet.conf',
    section => 'master',
    setting => 'autosign',
    value   => '/etc/puppetlabs/puppet/autosign.rb',
    notify  => Service['pe-puppetserver'],
  }
}
