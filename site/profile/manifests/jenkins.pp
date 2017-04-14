class profile::jenkins {
  include jenkins

  jenkins::plugin { 'puppet-enterprise-pipeline': }
  jenkins::plugin { 'plain-credentials': }
  
}
