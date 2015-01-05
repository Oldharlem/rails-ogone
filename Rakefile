require 'rubygems'
require 'bundler'

begin
  Bundler.setup(:default, :development)
rescue Bundler::BundlerError => e
  $stderr.puts e.message
  $stderr.puts "Run `bundle install` to install missing gems"
  exit e.status_code
end

require 'rake'
require 'jeweler'

Jeweler::Tasks.new do |gem|
  gem.name = 'rails-ogone'
  gem.homepage = 'https://github.com/davelens/rails-ogone'
  gem.license = 'MIT'
  gem.summary = 'Rails gem to facilitate simple payments with Ogone.'
  gem.description = 'Rails gem to facilitate simple payments with Ogone.'
  gem.email = 'github@davelens.be'
  gem.authors = ['Dave Lens']

  gem.files.include 'lib/**/*'
end
Jeweler::RubygemsDotOrgTasks.new

require 'rdoc/task'
Rake::RDocTask.new do |rdoc|
  version = File.exist?('VERSION') ? File.read('VERSION') : ""

  rdoc.rdoc_dir = 'rdoc'
  rdoc.title = "rails-ogone #{version}"
  rdoc.rdoc_files.include('README*')
  rdoc.rdoc_files.include('lib/**/*.rb')
end
