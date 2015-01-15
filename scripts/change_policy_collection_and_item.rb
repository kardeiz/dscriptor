Dscriptor.configure do
  self.admin_email = 'j.h.brown@tcu.edu'
  self.dspace_cfg  = '/home/jhbrown/projects/dspace4/config/dspace.cfg'
  self.imports.merge [
    'org.dspace.authorize.AuthorizeManager',
    'org.dspace.eperson.Group',
    'org.dspace.core.Constants'
  ]
end

Dscriptor.perform do

  with_collection '116099117/236' do |c|
    admins = Group.find_by_name(context, "Anonymous")
    AuthorizeManager.remove_all_policies(context, c)
    AuthorizeManager.add_policy(context, c, Constants::READ, admins)
    c.update
    items = c.items
    while item = items.next
      AuthorizeManager.remove_all_policies(context, item)
      AuthorizeManager.inherit_policies(context, c, item)
      item.update
    end
  end

end