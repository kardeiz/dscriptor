# dscriptor

A small gem to help create administrative task scripts for working with the DSpace API.

## Installation

Make sure you have a recent version of JRuby installed.

Clone the repo: 

`git clone https://github.com/kardeiz/dscriptor.git`

## Usage

Create a new script `*.rb` file in `lib/dscriptor/scripts`.

Configure your settings:

```ruby
Dscriptor.configure do
  self.admin_email = 'your email'
  self.dspace_cfg  = 'path to your dspace.cfg file'
  # add here any classes you would like to have access to;
  # a number of classes are preloaded, see "lib/dscriptor.rb"
  self.imports    << 'org.dspace.content.Bundle'
end
```

Load up the runtime context:

```ruby
Dscriptor.perform do
  # your code goes here
end
```

On entering this block, the DSpace jars and configuration will be loaded, and specified classes will be imported to your current context. The DSpace `ServiceManager` will be started as well.

Inside this scope you have access to a few convenience methods:

* `context` - your admin context
* `with_{community, collection, item}` - used to lookup DSpaceObject by handle or ID, yields the object to a block

You can also access any of the loaded Java classes by name (e.g., `HandleManager`).

The `perform` block will `complete` (close) your context for you on exit

Once you have completed your script, go back to your command line and:

`script=[name of your script file without the extension] bundle exec rake perform`

DSpace logging, as well as any `puts` commands in your script, will be output to the terminal.

## Contributing

Pull requests are more than welcome. I'll be extending the gem only in my free time.

1. Fork it ( https://github.com/kardeiz/dscriptor/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
