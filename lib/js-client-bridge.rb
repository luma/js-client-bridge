$:.unshift(File.dirname(__FILE__)) unless
  $:.include?(File.dirname(__FILE__)) || $:.include?(File.expand_path(File.dirname(__FILE__)))

module JsClientBridge
  VERSION = '0.1.0'
end

require 'rubygems'
require 'json'
require "extlib"

require 'js-client-bridge/responses'
require 'js-client-bridge/extensions/datamapper_errors'