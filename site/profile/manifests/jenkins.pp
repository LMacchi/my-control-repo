class profile::jenkins {
  include jenkins

  jenkins::plugin { 'puppet-enterprise-pipeline': }
  jenkins::plugin { 'plain-credentials': }
  jenkins::plugin { 'workflow-api': }
  jenkins::plugin { 'workflow-basic-steps': }
  jenkins::plugin { 'workflow-cps': }
  jenkins::plugin { 'workflow-durable-task-step': }
  jenkins::plugin { 'credentials': }
  jenkins::plugin { 'script-security': }
  jenkins::plugin { 'structs': }
  
}
