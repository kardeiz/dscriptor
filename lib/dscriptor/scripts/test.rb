Dscriptor.configure do
  self.admin_email = 'j.h.brown@tcu.edu'
  self.dspace_cfg  = '/home/jhbrown/projects/dspace4/config/dspace.cfg'
  self.imports    << ['org.dspace.content.Bundle']
end

Dscriptor.perform do

  puts Bundle

  with_collection '116099117/236' do |c|
    c.set_metadata('name', 'new name')
    c.update
    puts c.name
  end

end