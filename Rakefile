require 'rake'
require 'rake/testtask'
require 'rake/rdoctask'

require 'gemmer'

desc 'Default: run unit tests.'
task :default => :test

desc 'Test the acts_as_formatted plugin.'
Rake::TestTask.new(:test) do |t|
  t.libs << 'lib'
  t.pattern = 'test/**/*_test.rb'
  t.verbose = true
end

desc 'Generate documentation for the acts_as_formatted plugin.'
Rake::RDocTask.new(:rdoc) do |rdoc|
  rdoc.rdoc_dir = 'rdoc'
  rdoc.title    = 'ActsAsFormatted'
  rdoc.options << '--line-numbers' << '--inline-source'
  rdoc.rdoc_files.include('README')
  rdoc.rdoc_files.include('lib/**/*.rb')
end

Gemmer::Tasks.new("acts_as_formatted") do |t|
  t.release_via :rubygems
end