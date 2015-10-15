module DependencyInspector
  module RubyGemfile
    class Source
      attr_reader :remotes
      attr_accessor :dependency_names

      def initialize(options = {})
        @options = options
        @remotes = []
        Array(options['remotes'] || []).reverse_each { |r| add_remote(r) }
      end

      def eql?(o)
        o.is_a?(Source) && remotes_equal?(o.remotes)
      end

      alias_method :==, :eql?

      def add_remote(source)
        uri = normalize_uri(source)
        @remotes.unshift(uri) unless @remotes.include?(uri)
      end

      def normalize_uri(uri)
        uri = uri.to_s
        uri = "#{uri}/" unless uri =~ %r{/$}
        uri = URI(uri)
        fail Exception, 'The source must be an absolute URI' unless uri.absolute?
        uri
      end
    end
  end
end
