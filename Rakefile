=begin
%w[rubygems rake rake/clean fileutils newgem rubigen].each { |f| require f }
require File.dirname(__FILE__) + '/lib/js-client-bridge'

# Generate all the Rake tasks
# Run 'rake -T' to see list of generated tasks (from gem root directory)
$hoe = Hoe.new('js-client-bridge', JsClientBridge::VERSION) do |p|
  p.developer('Rolly', 'rolly@luma.co.nz')
  p.changes              = p.paragraphs_of("History.txt", 0..1).join("\n\n")
  p.post_install_message = 'PostInstall.txt' # TODO remove if post-install message not required
  p.rubyforge_name       = p.name # TODO this is default value
  p.extra_deps         = [
  #   ['activesupport','>= 2.0.2'],
    ['json', '>= 0'],
    ['extlib', '>= 0']
  ]
  p.extra_dev_deps = [
    ['newgem', ">= #{::Newgem::VERSION}"]
  ]
  
  p.clean_globs |= %w[**/.DS_Store tmp *.log]
  path = (p.rubyforge_name == p.name) ? p.rubyforge_name : "\#{p.rubyforge_name}/\#{p.name}"
  p.remote_rdoc_dir = File.join(path.gsub(/^#{p.rubyforge_name}\/?/,''), 'rdoc')
  p.rsync_args = '-av --delete --ignore-errors'
end

require 'newgem/tasks' # load /tasks/*.rake
Dir['tasks/**/*.rake'].each { |t| load t }

# TODO - want other tests/tasks run by default? Add them to the list
# task :default => [:spec, :features]

desc "Run all examples (or a specific spec with TASK=xxxx)"
Spec::Rake::SpecTask.new('spec') do |t|
  t.spec_opts  = ["-cfs"]
  t.spec_files = begin
    if ENV["TASK"] 
      ENV["TASK"].split(',').map { |task| "spec/**/#{task}_spec.rb" }
    else
      FileList['spec/**/*_spec.rb']
    end
  end
end

#desc 'Default: run spec examples'
#task :default => 'spec'
=end
# -*- ruby -*-

require 'rubygems'
require 'hoe'
require 'fileutils'
require 'newgem'
require 'rubigen'

#require File.dirname(__FILE__) + '/lib/js-client-bridge'

Hoe.spec 'js-client-bridge' do
  developer 'Rolly', 'rolly@luma.co.nz'

  extra_deps << ['json', '>= 0']
  extra_deps << ['extlib', '>= 0']

#  extra_dev_deps << ['newgem', ">= #{::Newgem::VERSION}"]
=begin  
  clean_globs |= %w[**/.DS_Store tmp *.log]
  path = (p.rubyforge_name == p.name) ? p.rubyforge_name : "\#{p.rubyforge_name}/\#{p.name}"
  remote_rdoc_dir = File.join(path.gsub(/^#{p.rubyforge_name}\/?/,''), 'rdoc')
  rsync_args = '-av --delete --ignore-errors'
=end
end

# vim: syntax=ruby

