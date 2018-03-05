class profile::beaker {

  package { ['make', 'gcc', 'gcc-c++', 'libxml2-devel', 'libxslt-devel', 'ruby-devel']:
    ensure => present,
    before => Class['rvm'],
  }

  include rvm

  rvm_system_ruby { 'ruby-2.4.0':
    ensure      => present,
    default_use => true,
  }

  rvm_gem { 'beaker':
    name         => 'beaker',
    ruby_version => 'ruby-2.4.0',
    ensure       => latest,
    require      => Rvm_system_ruby['ruby-2.4.0'],
  }

  include docker

}
