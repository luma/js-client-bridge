require 'rubygems'
require "rspec"
require 'ruby-debug'
require 'pp'

$:.unshift(File.dirname(__FILE__) + '/../lib')
require 'js-client-bridge'

RSpec.configure do |config|
  config.mock_with :mocha
end