# -*- encoding: utf-8 -*-
require File.expand_path("../lib/js-client-bridge/version", __FILE__)

Gem::Specification.new do |s|
  s.name        = "js-client-bridge"
  s.version     = JsClientBridge::VERSION
  s.platform    = Gem::Platform::RUBY
  s.authors     = ['Rolly Fordham']
  s.email       = ['rolly@luma.co.nz']
  s.homepage    = "http://rubygems.org/gems/js-client-bridge"
  s.summary     = "Standardised way of talking between a service and javascript"
  s.description = "Little library that encapsulates a (particular) standardised way of talking between a service and javascript. Probably not the best way of doing things, but it's been handy in a pinch."

  s.required_rubygems_version = ">= 1.3.6"
  s.rubyforge_project         = "js-client-bridge"

  s.add_dependency "json_pure", "~> 1.4.6"

  s.add_development_dependency "bundler", ">= 1.0.0"
  s.add_development_dependency "rspec", "~> 2.0.0"
  s.add_development_dependency "rcov", "~> 0.9.8"
  s.add_development_dependency "mocha", "~> 0.9.8"

  DM_VERSION = "~> 1.0.2"
  s.add_development_dependency "dm-core",           DM_VERSION
  s.add_development_dependency 'dm-aggregates',     DM_VERSION
  s.add_development_dependency 'dm-migrations',     DM_VERSION
  s.add_development_dependency 'dm-timestamps',     DM_VERSION
  s.add_development_dependency 'dm-validations',    DM_VERSION
  s.add_development_dependency 'dm-types',          DM_VERSION
  s.add_development_dependency 'dm-sqlite-adapter', DM_VERSION

  if RUBY_VERSION > '1.9.0'
    s.add_development_dependency "ruby-debug19", "~> 0.11.6"
  else
    s.add_development_dependency "ruby-debug", "~> 0.10.3"
  end

  s.files        = `git ls-files`.split("\n")
  s.executables  = `git ls-files`.split("\n").map{|f| f =~ /^bin\/(.*)/ ? $1 : nil}.compact
  s.require_path = 'lib'
end