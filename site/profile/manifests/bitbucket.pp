class profile::bitbucket {

  $bb_version = lookup('bitbucket_version')

  file { '/tmp/bb_installer.bin':
    source => "https://www.atlassian.com/software/stash/downloads/binary/atlassian-bitbucket-${bb_version}-x64.bin",
    mode   => '0755',
  }

  # Run BitBucket Installer
  exec { 'Run Bitbucket Server Installer':
    command   => '/tmp/bb_installer.bin -q',
    creates   => "/opt/atlassian/bitbucket/${bitbucket_version}/bin/_start-webapp.sh",
    logoutput => true,
    require   => [
      File['/tmp/bb_installer.bin'],
      Package['git'],
    ],
  }

  file { '/usr/bin/keytool':
    ensure => link,
    target => "/opt/atlassian/bitbucket/${bitbucket_version}/jre/bin/keytool",
  }

  file { 'bitbucket.service':
    ensure  => file,
    path    => '/etc/systemd/system/bitbucket.service',
    mode    => '0644',
    owner   => 'root',
    group   => 'root',
    content => epp('profile/bitbucket.service.epp'),
    notify  => Exec['reload systemctl'],
  }

  exec { 'reload systemctl':
    command     => 'systemctl daemon-reload',
    path        => $facts['path'],
    refreshonly => true,
  }

  service { 'bitbucket':
    ensure  => running,
    enable  => true,
    require => [
      Exec['Run Bitbucket Server Installer'],
      File['bitbucket.service'],
      Exec['reload systemctl'],
    ]
  }

  # Add the Puppet CA as a trusted certificate authority because
  # the webhook add-on must use a trusted connection.
  java_ks { $::settings::server :
    ensure       => latest,
    certificate  => "${::settings::certdir}/ca.pem",
    target       => "/opt/atlassian/bitbucket/${bitbucket_version}/jre/lib/security/cacerts",
    password     => 'changeit',
    trustcacerts => true,
    require      => [ Exec['Run Bitbucket Server Installer'], File['/usr/bin/keytool'] ],
    notify       => Service['bitbucket'],
  }


}
