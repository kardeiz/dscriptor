require 'dscriptor/version'
require 'dscriptor/config'
require 'dscriptor/runtime'
require 'dscriptor/mixins'

module Dscriptor

  ROOT = File.expand_path('../..', __FILE__)

  def self.config; @config ||= Config.new; end

  def self.configure(&blk)
    yield config if block_given?
    self
  end

  def self.runtime; @runtime ||= Runtime.new; end

  def self.prepare; runtime.prepare; end

end
