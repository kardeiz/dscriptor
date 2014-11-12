require "bundler/gem_tasks"
require 'dscriptor'

task :perform do
  name = ENV['script'] || raise('Please specify file')
  require "dscriptor/scripts/#{name}"
end