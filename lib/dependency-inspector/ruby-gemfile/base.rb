module DependencyInspector
  require 'gems'
  module RubyGemfile
    autoload :Resolver, 'dependency-inspector/ruby-gemfile/resolver'
    autoload :Source, 'dependency-inspector/ruby-gemfile/source'
    autoload :Requirement, 'dependency-inspector/ruby-gemfile/requirement'
    autoload :SourceList, 'dependency-inspector/ruby_gemfile/source_list'
    autoload :Dependency, 'dependency-inspector/ruby_gemfile/dependency'
    autoload :Definition, 'dependency-inspector/ruby_gemfile/definition'
    class << self
    end
  end
end
