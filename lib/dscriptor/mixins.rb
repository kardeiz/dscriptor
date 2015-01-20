module Dscriptor
  module Mixins

    def context
      @context ||= Context.new.tap do |o|
        next unless email = Dscriptor.config.admin_email
        next unless eperson = EPerson.find_by_email(o, email)
        o.current_user = eperson
      end
    end

    alias_method :dspace_context, :context

    def with_dso(arg, klass = nil)
      obj = if String === arg
        HandleManager.resolve_to_object(context, arg)
      elsif Integer === arg
        klass.find(context, arg)
      else arg
      end
      block_given? ? yield(obj) : obj
    end

    def with_community(arg, &blk);  with_dso(arg, Community, &blk); end
    def with_collection(arg, &blk); with_dso(arg, Collection, &blk); end
    def with_item(arg, &blk);       with_dso(arg, Item, &blk); end
    
  end
end
