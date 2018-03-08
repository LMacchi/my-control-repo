class profile::bitbucket {

  file { ['/opt/atlassian','/opt/atlassian/application-data']:
    ensure => directory,
  }

  package { ['git','unzip']:
    ensure => present,
  }

  include java

  class { 'bitbucket':
    version        => '5.5.0',
    installdir     => '/opt/atlassian/atlassian-bitbucket',
    homedir        => '/opt/atlassian/application-data/bitbucket-home',
    javahome       => '/usr/lib/jvm/java-8-openjdk-amd64/jre',
    jvm_xms        => '1G',
    jvm_xmx        => '4G',
  }

  class { 'bitbucket::facts': }
  class { 'bitbucket::gc': }
}
