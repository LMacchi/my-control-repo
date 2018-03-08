class profile::bitbucket {

  $bb_version = lookup('bitbucket_version')

  file { ['/opt/atlassian','/opt/atlassian/application-data']:
    ensure => directory,
  }

  package { 'unzip':
    ensure => present,
  }

  firewalld_port { 'Open port 7990':
    ensure   => present,
    zone     => 'public',
    port     => '7990',
    protocol => 'tcp',
  }

  firewalld_port { 'Open port 7999':
    ensure   => present,
    zone     => 'public',
    port     => '7999',
    protocol => 'tcp',
  }

  include java
  include postgresql::server

  class { 'bitbucket':
    version        => $bb_version,
    installdir     => '/opt/atlassian/atlassian-bitbucket',
    homedir        => '/opt/atlassian/application-data/bitbucket-home',
    javahome       => '/usr/lib/jvm/java-8-openjdk-amd64/jre',
  }

  class { 'bitbucket::facts': }
  class { 'bitbucket::gc': }
}
