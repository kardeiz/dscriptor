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

with_collection '116099117/236' do |c|
  anon = Group.find_by_name(context, "Anonymous")
  AuthorizeManager.remove_all_policies(context, c)
  AuthorizeManager.add_policy(context, c, Constants::READ, anon)
  c.update
  items = c.items
  
  while item = items.next do
    AuthorizeManager.remove_all_policies(context, item)
    AuthorizeManager.inherit_policies(context, c, item)
    item.update
  end
end

context.complete