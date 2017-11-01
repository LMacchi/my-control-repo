# There's no module for jenkins 2, so let's do a quick one
class profile::jenkins2 {
  yumrepo { 'jenkins':
    ensure   => 'present',
    baseurl  => 'http://pkg.jenkins.io/redhat',
    descr    => 'Jenkins',
    gpgcheck => '1',
  }
  
  rpmkey { 'D50582E6':
    ensure => 'present',
    source => 'https://jenkins-ci.org/redhat/jenkins-ci.org.key',
  }
  
  package { ['java','jenkins']:
    ensure => present,
  }
  
  # Disable setup wizard
  file { '/etc/default/jenkins':
    ensure  => file,
    content => 'JAVA_ARGS=Djenkins.install.runSetupWizard=false',
  }
  
  service { 'jenkins':
    ensure => running,
  }
  
  Yumrepo['jenkins'] 
  -> Rpmkey['D50582E6']
  -> Package['java']
  -> Package['jenkins']
  -> File['/etc/default/jenkins']
  ~> Service['jenkins']
}
