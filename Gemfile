source 'https://rubygems.org'

gem 'aws-sdk-core'

group :development, :unit_tests do
  gem 'rspec-puppet'
  gem 'simplecov', :require => false
  gem 'puppetlabs_spec_helper'
end

group :system_tests do
  gem 'beaker-rspec', '4.0.0', :require => false
  gem 'serverspec', :require => false
end

if facterversion = ENV['FACTER_GEM_VERSION']
  gem 'facter', facterversion, :require => false
else
  gem 'facter', '1.7.6', :require => false
end

if puppetversion = ENV['PUPPET_GEM_VERSION']
  gem 'puppet', puppetversion, :require => false
else
  gem 'puppet', :require => false
end
