module DependencyInspector
  module RubyGemfile
    class Requirement
      attr_reader :requirements

      OPS = {
        '=': lambda { |v, r| v == r },
        '!=': lambda { |v, r| v != r },
        '>': lambda { |v, r| v >  r },
        '<': lambda { |v, r| v <  r },
        '>=': lambda { |v, r| v >= r },
        '<=': lambda { |v, r| v <= r },
        '~>': lambda { |v, r| v >= r && v.release < r.bump }
      }

      quoted  = OPS.keys.map { |k| Regexp.quote k }.join '|'
      VERSION_PATTERN = '[0-9]+(?>\.[0-9a-zA-Z]+)*(-[0-9A-Za-z-]+(\.[0-9A-Za-z-]+)*)?'
      PATTERN_RAW = "\\s*(#{quoted})?\\s*(#{VERSION_PATTERN})\\s*"
      PATTERN = /\A#{PATTERN_RAW}\z/

      DEFAULT_REQUIREMENT = ['>=', 0]

      def initialize(*requirements)
        requirements = requirements.flatten
        requirements.compact!
        requirements.uniq!

        p "requirements: #{requirements}"

        if requirements.empty?
          @requirements = [DEFAULT_REQUIREMENT]
        else
          @requirements = requirements.map! { |r| self.class.parse r }
        end
      end

      def self.create(requirements)
        case requirements
          when RubyGemfile::Requirement then
            requirements
          when Array then
            new requirements
          else
            if input.respond_to? :to_str
              new [input.to_str]
            else
              default
            end
        end
      end

      def self.default
        new ['>= 0']
      end

      def self.parse(obj)
        unless PATTERN =~ obj.to_s
          raise Exception, "Wrong requirement [#{obj.inspect}]"
        end

        if $1 == '>=' && $2 == '0'
          DEFAULT_REQUIREMENT
        else
          [$1 || '=', $2]
        end
      end
    end
  end
end
