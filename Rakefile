require 'rake/testtask'
require 'rubygems/tasks'

Rake::TestTask.new do |t|
  t.pattern = 'test/*_test.rb'
end

desc 'Run tests'
task default: :test

Gem::Tasks.new