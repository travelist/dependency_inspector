module DependencyInspector
  module RubyGemfile
    class Dependency
      attr_accessor :name, :version, :source, :groups
      def initialize(name, version, options={}, &blk)
        @name, @version = name, version
        @groups = Array(options['group'] || :default).map { |g| g.to_sym }
        @source = options['source']
        @requirements = RubyGemfile::Requirement.create(version)
      end
    end
  end
end
