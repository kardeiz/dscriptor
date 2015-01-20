module Dscriptor
  class Runtime

    def kernel_impl
      @kernel_impl ||= org.dspace.servicemanager.DSpaceKernelInit.get_kernel(nil)
    end

    def prepare
      @prepare ||= begin
        Dscriptor.config.dspace_jars.each { |jar| require jar }        
        org.dspace.core.ConfigurationManager.load_config(Dscriptor.config.dspace_cfg)
        Dscriptor.config.imports.each {|i| java_import i }
        kernel_impl.start(Dscriptor.config.dspace_dir) unless kernel_impl.is_running
        true
      end
    end

  end
end