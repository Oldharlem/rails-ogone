ENV['RAILS_ENV'] ||= 'test'
require 'rspec'
$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), '..', 'lib'))
$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), '..', 'lib', 'generators', 'templates'))
$LOAD_PATH.unshift(File.dirname(__FILE__))
$LOAD_PATH.unshift(File.expand_path('../lib/generators/ogone/templates', __FILE__))

require 'rails-ogone'
