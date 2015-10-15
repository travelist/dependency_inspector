module DependencyInspector
  module RubyGemfile
    class Dependency
      attr_accessor :name, :version, :source, :groups
      def initialize(name, version, options = {}, &_blk)
        @name = name
        @version = version
        @groups = Array(options['group'] || :default).map(&:to_sym)
        @source = options['source']
        @requirements = RubyGemfile::Requirement.create(version)
      end
    end
  end
end
