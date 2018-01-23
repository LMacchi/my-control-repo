# There's no module for jenkins 2, so let's do a quick one
class profile::jenkins2 {
  yumrepo { 'jenkins':
    ensure   => 'present',
    baseurl  => 'http://pkg.jenkins.io/redhat',
    descr    => 'Jenkins',
    gpgcheck => '1',
  }
  
  rpmkey { 'D50582E6':
    ensure  => present,
    source  => 'https://jenkins-ci.org/redhat/jenkins-ci.org.key',
    require => Yumrepo['jenkins'],
  }
  
  package { 'java':
    ensure => present,
  }
  
  package { 'jenkins':
    ensure  => present,
    require => [Package['java'],Yumrepo['jenkins'],Rpmkey['D50582E6']],
  }
  
  # Disable security
  file_line { 'disable security in jenkins':
    path    => '/var/lib/jenkins/config.xml',
    line    => '<useSecurity>false</useSecurity>',
    match   => '<useSecurity>.*<\/useSecurity>',
    require => Package['jenkins'],
    notify  => Service['jenkins'],
  }
  
  # Disable setup wizard
  file { '/etc/default/jenkins':
    ensure  => file,
    content => 'JAVA_ARGS=Djenkins.install.runSetupWizard=false',
    require => Package['jenkins'],
    notify  => Service['jenkins'],
  }
  
  service { 'jenkins':
    ensure => running,
  }
}
