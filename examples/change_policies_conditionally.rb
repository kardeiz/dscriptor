#!/usr/bin/env jruby

require 'dscriptor'
require 'date'

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

class Item

  def my_date
    self.get_metadata("dc.date.issued").map(&:value).first.tap do |o|
      unless o.nil?
        re = /(\d{4})\-?(\d{2})?\-?(\d{2})?/
        ar = o.scan(re).flatten.compact.map(&:to_i)
        return (Date.new(*ar) rescue nil)
      end
    end
  end

end

collection = HandleManager.resolve_to_object(context, 'some handle')
anonymous  = Group.find_by_name(context, "Anonymous")
items      = collection.items
chk_date   = Date.new(2012, 10, 30)

while item = items.next do

  next if     item.my_date.nil?
  next unless item.my_date < chk_date

  bundles    = item.get_bundles("ORIGINAL")
  bitstreams = bundles.map { |bn| bn.bitstreams }.flatten

  bitstreams.each do |bs|
    puts bs.name
    AuthorizeManager.remove_all_policies(context, bs)
    AuthorizeManager.add_policy(context, bs, Constants::READ, anonymous)
  end
end

context.complete