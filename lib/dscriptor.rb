require 'dscriptor/version'
require 'dscriptor/runtime'
require 'set'

module Dscriptor

  class Config

    attr_accessor :admin_email, :dspace_cfg

    def dspace_dir
      @dspace_dir ||= File.expand_path('../..', dspace_cfg)
    end

    def dspace_jars
      @dspace_jars ||= Dir[File.join(dspace_dir, 'lib/*.jar')]
    end

    def imports
      @imports ||= [
        'org.dspace.core.ConfigurationManager',
        'org.dspace.eperson.EPerson',
        'org.dspace.core.Context',
        'org.dspace.handle.HandleManager',
        'org.dspace.servicemanager.DSpaceKernelInit',
        'org.dspace.content.DSpaceObject',
        'org.dspace.content.Community',
        'org.dspace.content.Collection',
        'org.dspace.content.Item',
        'org.dspace.content.Bitstream'
      ].to_set
    end

  end

  def self.config; @config ||= Config.new; end

  def self.configure(&blk); config.instance_eval(&blk); end

  def self.perform(&blk)
    r = Runtime.new
    r.instance_eval(&blk)
    r.context.complete
  end

end
