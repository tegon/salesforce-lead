require File.expand_path('../lib/salesforce/version', __FILE__)

Gem::Specification.new do |s|
  s.name        = 'salesforce-lead'
  s.summary     = 'Salesforce Lead'
  s.description = 'Create a Lead in Salesforce'
  s.authors     = ['Leonardo Tegon']
  s.email       = 'ltegon93@gmail.com'
  s.files       = [
    'lib/salesforce/lead.rb',
    'lib/salesforce/version.rb'
  ]
  s.homepage    = 'https://github.com/tegon/salesforce-lead'
  s.license     = 'MIT'
  s.version     = Salesforce::VERSION

  s.add_dependency 'httparty', '0.13.5'
  s.add_development_dependency 'minitest', '5.5'
  s.add_development_dependency 'rubygems-tasks', '0.2.4'
  s.add_development_dependency 'webmock', '1.21.0'
end