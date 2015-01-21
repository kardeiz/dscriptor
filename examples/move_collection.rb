#!/usr/bin/env jruby

require 'dscriptor'

Dscriptor.configure do |c|
  c.dspace_cfg = ENV['DSPACE_CFG']
  c.admin_email = ENV['ADMIN_EMAIL']
  c.imports.merge %w{
    org.dspace.authorize.AuthorizeManager
    org.dspace.eperson.Group
    org.dspace.core.Constants
  }
end.prepare

include Dscriptor::Mixins

coll = HandleManager.resolve_to_object(context, '116099117/236')
oldc = HandleManager.resolve_to_object(context, '116099117/123')
newc = HandleManager.resolve_to_object(context, '116099117/347')

# newc.add_collection(coll)
# oldc.remove_collection(coll)

puts "Moved #{coll.name} from #{oldc.name} to #{newc.name}"

# context.complete