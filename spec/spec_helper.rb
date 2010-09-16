require 'rubygems'
require 'spec'
require 'ruby-debug'
require 'pp'

$:.unshift(File.dirname(__FILE__) + '/../lib')
require 'js-client-bridge'

Spec::Runner.configure do |config|
  config.mock_with :mocha
end