# dscriptor

A small gem to help create administrative task scripts for working with the DSpace API.

## Installation

Make sure you have a recent version of JRuby installed.

I'm still ironing out the implementation details. For now, the easiest way to install/use this tool is to:

Clone the repo: 

`git clone https://github.com/kardeiz/dscriptor.git`

Bundle:

`bundle`

You can then run your script like:

`bundle exec jruby myscript.rb`

See the `examples` directory for examples.

## Usage


Create a new script `*.rb` file.

Require the gem and any other dependencies you might have:

```ruby
require 'dscriptor'
```

Configure the tool (add any java classes you need to the `imports` list so that you can access them more conveniently):

```ruby
Dscriptor.configure do |c|
  c.dspace_cfg = ENV['DSPACE_CFG']
  c.admin_email = ENV['ADMIN_EMAIL']
  c.imports.merge %w{
    org.dspace.authorize.AuthorizeManager
    org.dspace.authorize.ResourcePolicy
    org.dspace.storage.rdbms.TableRow
  }
end
```

Prepare the runtime:

```ruby
Dscriptor.prepare
```

This starts the DSpace kernel, requires all of the core `jar` files, and imports the specified java classes.

Include the tool's `mixins` (optional):

```ruby
include Dscriptor::Mixins
```

This will add a number of convenience methods to your current context (e.g., `context`, which is the DSpace context for your admin user).

You can then do whatever you like within your script. Remember to call `context.complete` before exiting your script if you have made any changes to DSpace.

## Notes

Versioning is very casual. Things will probably break between versions. Use at your own risk.

## Contributing

Pull requests are more than welcome. I'll be extending the gem only in my free time.

1. Fork it ( https://github.com/kardeiz/dscriptor/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
