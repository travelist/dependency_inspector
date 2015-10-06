module DependencyInspector
  module RubyGemfile
    class Resolver
      def self.resolve(index, dependencies, source_requirements)
        reqs = dependencies.map(&:name)
        resolver = new(index, source_requirements)
        resolver.start(reqs)
      end

      def initialize(index, source_requirements)
        @initial_reqs         = []
        @index                = index
        @missing_gems         = Hash.new(0)
        @source_requirements  = source_requirements
        @started_at           = Time.now
      end

      def start(reqs, current_traversal = false)
        activated = {}
        @initial_reqs = reqs.dup unless current_traversal
        resolve(reqs, activated, current_traversal)
      end

      def resolve(reqs, _activated, _current_traversal)
        results = []
        reqs.each do |r|
          result = search(r)
          next if result.empty?
          # TODO: select correct version instead of 'result.first'
          results.push(result.first)
        end
        results
      end

      def search(gem_name)
        Gems.search(gem_name)
      end
    end
  end
end
