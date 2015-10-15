# Dependency Inspector [![License](http://img.shields.io/:license-mit-blue.svg)](http://doge.mit-license.org) [![Circle CI](https://circleci.com/gh/travelist/dependency-inspector.svg?style=shield&circle-token=a5c5179f69fddb1a3eeae0a33aad56de84be3701)](https://circleci.com/gh/travelist/dependency-inspector) [![Gem Version](https://badge.fury.io/rb/dependency_inspector.svg)](https://badge.fury.io/rb/dependency_inspector)

This gem is for analysing dependencies files such as `Gemfile` and list libraries with their information.

*Currently only `Gemfile` is supported. Others will come to be supported*

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

*NOTE: Since this is primitive project, the following usages is not ensured to be consistent for the future versions*

```ruby
# include this gem
require 'dependency-inspector'
```

```ruby
gemfile_filepath = "#{Dir.pwd}/Gemfile"
di = DependencyInspector::RubyGemfile::Dsl.evaluate(gemfile_filepath)
```
> It can cope with the text as well
```ruby
gemfile_txt = <<EOR
source 'https://rubygems.org'
gem 'dependency_inspector'
EOR
di = DependencyInspector::RubyGemfile::Dsl.evaluate(gemfile_txt)

```ruby
dependency_info = di.resolve
# this takes time according to the amount of the dependency libraries
```

```ruby
# currently library version is not supported (always return latest versoin info)
dependency_info.each do |i|
  p i["name"]              # => "rails"
  p i["downloads"]         # => 54525871
  p i["version"]           # => "4.2.4"
  p i["version_downloads"] # => 359907
  p i["platform"]          # => "ruby"
  p i["authors"]           # => "Dav..."
  p i["info"]              # => "Ruby"
  p i["licenses"]          # => ["MIT"]
  p i["metadata"]          # => {}
  p i["sha"]               # => "1c33de75..."
  p i["project_uri"]       # => "https://rubygems.org/gems/rails"
  p i["gem_uri"]           # => "https://rubygems.org/gems/rails-4.2.4.gem"
  p i["homepage_uri"]      # => "http://www.rubyonrails.org"
  p i["wiki_uri"]          # => "http://wiki.rubyonrails.org"
  p i["documentation_uri"] # => "http://api.rubyonrails.org"
  p i["mailing_list_uri"]  # => "http://groups.google.com/group/rubyonrails-talk"
  p i["source_code_uri"]   # => "http://github.com/rails/rails"
  p i["bug_tracker_uri"]   # => "http://github.com/rails/rails/issues"
  p i["dependencies"]      # => {"development"=>[], "runtime"=>[{"name"=>"actionmailer", "requirements"=>"= 4.2.4"}
end
```

## TODO

* Write test code
* support for other languages and dependency managers

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine
```
bundle exec rake install
```

Do not forget to execute `rubocop` before pushing the changes.

```shell
rubocop
```

## Contributing

1 Fork it ( https://github.com/travelist/dependency-inspector/fork )

2 Create your feature branch 
```shell
git checkout -b my-new-feature
```

3 Commit your changes 
```shell
git commit -am 'Add some feature'
```

4 Push to the branch
```shell
git push origin my-new-feature
```

5 Create a new Pull Request
