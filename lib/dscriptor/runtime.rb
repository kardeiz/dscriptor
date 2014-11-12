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

    def initialize; prepare && super; end

    def context
      @context ||= Context.new.tap do |o|
        next unless email = Dscriptor.config.admin_email
        next unless eperson = EPerson.find_by_email(o, email)
        o.current_user = eperson
      end
    end

    def with_dso(arg, klass = nil)
      obj = if String === arg
        HandleManager.resolve_to_object(context, arg)
      elsif Integer === arg
        klass.find(context, arg)
      else arg
      end
      yield obj if block_given?
    end

    def with_community(arg, &blk);  with_dso(arg, Community, &blk); end
    def with_collection(arg, &blk); with_dso(arg, Collection, &blk); end
    def with_item(arg, &blk);       with_dso(arg, Item, &blk); end

  end
end