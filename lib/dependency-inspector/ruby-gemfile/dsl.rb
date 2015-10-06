module DependencyInspector
  module RubyGemfile
    class Dsl
      attr_accessor :dependencies

      def initialize
        @source               = nil
        @sources              = RubyGemfile::SourceList.new
        @dependencies         = []
        @groups               = []
        @optional_groups      = []
      end

      def self.evaluate(gemfile)
        builder = new
        builder.eval_gemfile(gemfile)
        builder.to_definition
      end

      def eval_gemfile(gemfile)
        txt = File.open(gemfile, 'rb', &:read)
        instance_eval(txt, gemfile.to_s)
      end

      def normalize_source(src)
        case src
        when String
          src
        else
          fail Exception, "unknown source #{src}"
        end
      end

      def source(source, &blk)
        source = normalize_source(source)
        if block_given?
          with_source(@sources.add_rubygems_sources('remotes' => source), &blk)
        else
          @sources.add_rubygems_sources(source)
        end
      end

      def with_source(source)
        old_source = @source
        if block_given?
          @source = source
          yield
        end
        source
      ensure
        @source = old_source
      end

      def method_missing(name, *_args)
        p "currently #{name} is not supported"
      end

      def normalize_group_options(opts, groups)
        normalize_hash(opts)

        groups = groups.map { |group| ":#{group}" }.join(', ')
        validate_keys("group #{groups}", opts, %w(optional))

        opts['optional'] ||= false
      end

      def validate_keys(_command, opts, valid_keys)
        invalid_keys = opts.keys - valid_keys
        p 'error' if invalid_keys.any?
      end

      def group(*args, &_blk)
        opts = Hash === args.last ? args.pop.dup : {}
        normalize_group_options(opts, args)

        @groups.concat args

        if opts['optional']
          optional_groups = args - @optional_groups
          @optional_groups.concat optional_groups
        end

        yield
      ensure
        args.each { @groups.pop }
      end

      def normalize_hash(opts)
        opts.keys.each do |k|
          opts[k.to_s] = opts.delete(k) unless k.is_a?(String)
        end
        opts
      end

      def normalize_options(name, _version, opts)
        if name.is_a?(Symbol)
          fail Exception, %(You need to specify gem names as Strings. Use 'gem "#{name}"' instead.)
        end
        if name =~ /\s/
          fail Exception, %('#{name}' is not a valid gem name because it contains whitespace.)
        end

        normalize_hash(opts)

        groups = @groups.dup
        opts['group'] = opts.delete('groups') || opts['group']
        groups.concat Array(opts.delete('group'))
        groups = [:default] if groups.empty?

        if opts.key?('source')
          source = normalize_source(opts['source'])
          opts['source'] = @sources.add_rubygems_source('remotes' => source)
        end

        opts['source'] ||= @source
        opts['group'] = groups
      end

      def gem(name, *args)
        options = args.last.is_a?(Hash) ? args.pop.dup : {}
        version = args.empty? ? ['>= 0'] : args

        normalize_options(name, version, options)

        dep = RubyGemfile::Dependency.new(name, version, options)
        return if @dependencies.find { |d| d.name == dep.name }

        @dependencies << dep
      end

      def to_definition
        RubyGemfile::Definition.new(@dependencies, @sources)
      end
    end
  end
end
