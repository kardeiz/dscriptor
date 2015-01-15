module Dscriptor
  class Runtime

    def kernel_impl; @kernel_impl ||= DSpaceKernelInit.get_kernel(nil); end

    def prepare
      @prepared ||= begin
        raise "Error: no dspace.cfg specified" unless Dscriptor.config.dspace_cfg
        Dscriptor.config.dspace_jars.each { |jar| require jar }
        Dscriptor.config.imports.each {|i| java_import i }
        ConfigurationManager.load_config(Dscriptor.config.dspace_cfg)
        kernel_impl.start(Dscriptor.config.dspace_dir) unless kernel_impl.is_running
        true
      end
    end

  end
end