# profile/manifests/gitlab.pp
class profile::gitlab {
  Exec {
    path => '/usr/bin',
  }

  file { '/etc/gitlab':
    ensure => directory,
    owner  => 'root',
    group  => 'root',
    mode   => '0755',
  }

  file { '/etc/gitlab/ssl':
    ensure => directory,
    owner  => 'root',
    group  => 'root',
    mode   => '0700',
  }

  exec { 'create gitlab crt':
    command => 'openssl req -new -newkey rsa:4096 -days 365 -nodes -x509 -subj "/C=US/ST=Texas/L=Dallas/O=Puppet/CN=gitlab.puppetlabs.vm" -keyout "/etc/gitlab/ssl/gitlab.puppetlabs.vm.key" -out "/etc/gitlab/ssl/gitlab.puppetlabs.vm.crt"',
    creates => '/etc/gitlab/ssl/gitlab.puppetlabs.vm.crt',
    require => File['/etc/gitlab/ssl'],
  }

  class { 'gitlab':
    external_url => 'https://gitlab.puppetlabs.vm',
    nginx        => {
      ssl_certificate     => '/etc/gitlab/ssl/gitlab.puppetlabs.vm.crt',
      ssl_certificate_key => '/etc/gitlab/ssl/gitlab.puppetlabs.vm.key'
    },
    require      => Exec['create gitlab crt'],
  }
}
