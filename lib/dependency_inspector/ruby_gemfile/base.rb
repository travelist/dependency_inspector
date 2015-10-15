module DependencyInspector
  require 'gems'
  module RubyGemfile
    autoload :Definition, 'dependency_inspector/ruby_gemfile/definition'
    autoload :Dependency, 'dependency_inspector/ruby_gemfile/dependency'
    autoload :Dsl, 'dependency_inspector/ruby_gemfile/dsl'
    autoload :Requirement, 'dependency_inspector/ruby_gemfile/requirement'
    autoload :Resolver, 'dependency_inspector/ruby_gemfile/resolver'
    autoload :Source, 'dependency_inspector/ruby_gemfile/source'
    autoload :SourceList, 'dependency_inspector/ruby_gemfile/source_list'
  end
end
