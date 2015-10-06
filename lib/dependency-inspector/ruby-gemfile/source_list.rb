module DependencyInspector
  module RubyGemfile
    class SourceList
      def initialize
        @path_sources       = []
        @git_sources        = []
        @rubygems_sources   = []
      end

      def add_rubygems_sources(options = {})
        add_source_to_list RubyGemfile::Source.new(options), @rubygems_sources
      end

      def all_sources
        @path_sources + @git_sources + @rubygems_sources
      end

      private

      def add_source_to_list(source, list)
        list.unshift(source).uniq!
        source
      end
    end
  end
end
