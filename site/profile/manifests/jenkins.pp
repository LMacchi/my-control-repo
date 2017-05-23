class profile::jenkins {
  include jenkins

  jenkins::plugin { 'ace-editor': }
  jenkins::plugin { 'bouncycastle-api': }
  jenkins::plugin { 'branch-api': }
  jenkins::plugin { 'build-pipeline-plugin': }
  jenkins::plugin { 'cloudbees-folder': }
  jenkins::plugin { 'conditional-buildstep': }
  jenkins::plugin { 'copyartifact': }
  jenkins::plugin { 'credentials-binding': }
  jenkins::plugin { 'display-url-api': }
  jenkins::plugin { 'durable-task': }
  jenkins::plugin { 'git': }
  jenkins::plugin { 'git-client': }
  jenkins::plugin { 'git-server': }
  jenkins::plugin { 'handlebars': }
  jenkins::plugin { 'javadoc': }
  jenkins::plugin { 'jquery': }
  jenkins::plugin { 'jquery-detached': }
  jenkins::plugin { 'junit': }
  jenkins::plugin { 'mailer': }
  jenkins::plugin { 'matrix-project': }
  jenkins::plugin { 'maven-plugin': }
  jenkins::plugin { 'momentjs': }
  jenkins::plugin { 'parameterized-trigger': }
  jenkins::plugin { 'pipeline-build-step': }
  jenkins::plugin { 'pipeline-graph-analysis': }
  jenkins::plugin { 'pipeline-input-step': }
  jenkins::plugin { 'pipeline-milestone-step': }
  jenkins::plugin { 'pipeline-model-api': }
  jenkins::plugin { 'pipeline-model-definition': }
  jenkins::plugin { 'pipeline-model-declarative-agent': }
  jenkins::plugin { 'pipeline-model-extensions': }
  jenkins::plugin { 'pipeline-rest-api': }
  jenkins::plugin { 'pipeline-stage-step': }
  jenkins::plugin { 'pipeline-stage-tags-metadata': }
  jenkins::plugin { 'pipeline-stage-view': }
  jenkins::plugin { 'plain-credentials': }
  jenkins::plugin { 'puppet-enterprise-pipeline': }
  jenkins::plugin { 'run-condition': }
  jenkins::plugin { 'scm-api': }
  jenkins::plugin { 'script-security': }
  jenkins::plugin { 'ssh-agent': } 
  jenkins::plugin { 'ssh-credentials': }
  jenkins::plugin { 'structs': }
  jenkins::plugin { 'token-macro': }
  jenkins::plugin { 'workflow-aggregator': }
  jenkins::plugin { 'workflow-api': }
  jenkins::plugin { 'workflow-basic-steps': }
  jenkins::plugin { 'workflow-cps': }
  jenkins::plugin { 'workflow-cps-global-lib': }
  jenkins::plugin { 'workflow-multibranch': }
  jenkins::plugin { 'workflow-durable-task-step': }
  jenkins::plugin { 'workflow-job': 
    version => '2.11',
  }
  jenkins::plugin { 'workflow-scm-step': }
  jenkins::plugin { 'workflow-support': }
  jenkins::plugin { 'workflow-step-api': }


}
