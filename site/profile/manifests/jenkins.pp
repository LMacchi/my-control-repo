class profile::jenkins {
  include jenkins


  # Puppet plugin
  jenkins::plugin { 'puppet-enterprise-pipeline': }
  # Dependencies
  jenkins::plugin { 'ace-editor': }
  jenkins::plugin { 'display-url-api': }
  jenkins::plugin { 'durable-task': }
  jenkins::plugin { 'jquery-detached': }
  jenkins::plugin { 'mailer': }
  jenkins::plugin { 'plain-credentials': }
  jenkins::plugin { 'scm-api': }
  jenkins::plugin { 'script-security': }
  jenkins::plugin { 'structs': }
  jenkins::plugin { 'workflow-api': }
  jenkins::plugin { 'workflow-basic-steps': }
  jenkins::plugin { 'workflow-cps': }
  jenkins::plugin { 'workflow-durable-task-step': }
  jenkins::plugin { 'workflow-scm-step': }
  jenkins::plugin { 'workflow-support': }
  jenkins::plugin { 'workflow-step-api': }

  # Git Plugin
  jenkins::plugin { 'git': }
  # Dependencies
  jenkins::plugin { 'git-client': }
  jenkins::plugin { 'matrix-project': }
  jenkins::plugin { 'junit': }

  # SSH Plugin
  jenkins::plugin { 'ssh-agent': }
  # Dependencies
  jenkins::plugin { 'bouncycastle-api': }

}
