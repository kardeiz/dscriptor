#!/usr/bin/env jruby

require 'csv'

require 'dscriptor'

Dscriptor.configure do |c|
  c.dspace_cfg = ENV['DSPACE_CFG']
  c.admin_email = ENV['ADMIN_EMAIL']
  c.imports.merge %w{
    org.dspace.authorize.AuthorizeManager
    org.dspace.authorize.ResourcePolicy
    org.dspace.storage.rdbms.TableRow
  }
end.prepare

include Dscriptor::Mixins

puts Community.find_all(context).count