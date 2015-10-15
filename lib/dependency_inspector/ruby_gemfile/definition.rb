module DependencyInspector
  module RubyGemfile
    class Definition
      attr_reader :dependencies

      def initialize(dependencies, sources)
        @dependencies = dependencies
        @sources = sources
        @remote = false
        @expanded_dependencies = nil
      end

      def resolve
        @resolve ||= begin
          Resolver.resolve(index, dependencies, source_requirements)
        end
      end

      def source_requirements
        source_requirements = {}
        dependencies.each do |dep|
          next unless dep.source
          source_requirements[dep.name] = dep.source
        end
        source_requirements
      end

      def index
        dependency_names = @dependencies.map(&:name)
        @sources.all_sources.each do |source|
          source.dependency_names = dependency_names.dup
        end
      end
    end
  end
end
