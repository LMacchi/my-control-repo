source ENV['GEM_SOURCE'] || 'https://rubygems.org'

gem 'onceover, git 'https://github.com/LMacchi/onceover', :branch => 'trusted'

if puppetversion = ENV['PUPPET_GEM_VERSION']
  gem 'puppet', puppetversion, :require => false
else
  gem 'puppet', :require => false
end

gem 'pry'

# vim:ft=ruby
