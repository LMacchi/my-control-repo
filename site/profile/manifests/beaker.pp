class profile::beaker {

  $project_root = lookup('beaker_project_root', Stdlib::AbsolutePath, 'first', '/root/beaker_project')

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

  file { [$project_root, "${project_root}/acceptance", "${project_root}/acceptance/config", "${project_root}/acceptance/setup", "${project_root}/acceptance/tests"]:
    ensure => directory,
  }

}
