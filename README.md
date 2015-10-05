# Dependency Inspector

This gem is for analysing dependencies files such as `Gemfile` to detect which libraries are used for the project.
* Currently only `Gemfile` is supported *

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'dependency-inspector'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install dependency-inspector

## Usage

TODO: Write usage instructions here

## TODO

1. Write test code
2. support for other languages and dependency managers

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release` to create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

Do not forget to execute `rubocop` before pushing the changes.
```shell
rubocop
```

## Contributing

1. Fork it ( https://github.com/travelist/dependency-inspector/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
