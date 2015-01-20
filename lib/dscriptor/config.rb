require 'set'

module Dscriptor
  class Config
    attr_writer :dspace_cfg
    attr_accessor :admin_email

    def dspace_cfg; @dspace_cfg || raise('No dspace.cfg'); end

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
        'org.dspace.content.Bitstream',
        'org.dspace.storage.rdbms.DatabaseManager'
      ].to_set
    end
  end
end