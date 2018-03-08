class profile::bitbucket {

  $bb_version = lookup('bitbucket_version')

  file { ['/opt/atlassian','/opt/atlassian/application-data']:
    ensure => directory,
  }

  package { 'unzip':
    ensure => present,
  }

  include java
  include postgresql::server

  postgresql::server::db { 'bitbucket':
    user     => 'bitbucket',
    password => postgresql_password('bitbucket', 'password'),
  }

  class { 'bitbucket':
    version        => $bb_version,
    installdir     => '/opt/atlassian/atlassian-bitbucket',
    homedir        => '/opt/atlassian/application-data/bitbucket-home',
    javahome       => '/usr/lib/jvm/java-8-openjdk-amd64/jre',
  }

  class { 'bitbucket::facts': }
  class { 'bitbucket::gc': }
}
