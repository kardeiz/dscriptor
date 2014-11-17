Dscriptor.configure do
  self.admin_email = 'j.h.brown@tcu.edu'
  self.dspace_cfg  = '/home/jhbrown/projects/dspace4/config/dspace.cfg'
  self.imports.merge [

  ]
end

Dscriptor.perform do

  coll = HandleManager.resolve_to_object(context, '116099117/236')
  oldc = HandleManager.resolve_to_object(context, '116099117/123')
  newc = HandleManager.resolve_to_object(context, '116099117/347')

  newc.add_collection(coll)
  oldc.remove_collection(coll)

  puts coll.parent_object.name

end