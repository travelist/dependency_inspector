module DependencyInspector
  require 'gems'
  module RubyGemfile
    autoload :Definition, 'dependency-inspector/ruby-gemfile/definition'
    autoload :Dependency, 'dependency-inspector/ruby-gemfile/dependency'
    autoload :Dsl, 'dependency-inspector/ruby-gemfile/dsl'
    autoload :Requirement, 'dependency-inspector/ruby-gemfile/requirement'
    autoload :Resolver, 'dependency-inspector/ruby-gemfile/resolver'
    autoload :Source, 'dependency-inspector/ruby-gemfile/source'
    autoload :SourceList, 'dependency-inspector/ruby-gemfile/source-list'
  end
end
