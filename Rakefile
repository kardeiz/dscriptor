require "bundler/gem_tasks"
require 'dscriptor'

task :perform do
  scripts = File.join(Dscriptor::ROOT, 'scripts')
  $LOAD_PATH.unshift(scripts) unless $LOAD_PATH.include?(scripts)
  name = ENV['script'] || raise('Please specify file')
  load name
end

task :console do
  require 'irb'
  IRB.setup nil
  IRB.conf[:IRB_RC] = File.join(Dscriptor::ROOT, 'config/initializer.rb')
  IRB.conf[:MAIN_CONTEXT] = IRB::Irb.new.context
  require 'irb/ext/multi-irb'
  IRB.irb nil, self
end