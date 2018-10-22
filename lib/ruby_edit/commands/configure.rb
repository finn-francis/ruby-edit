# frozen_string_literal: true

require 'ruby_edit'

module RubyEdit
  module Commands
    # Configuration command class
    #
    # Gets called from the CLI configuration method
    class Configure
      CONFIGURATIONS = %i[editor grep_options].freeze

      def initialize(options)
        @options = options
      end

      # Determins whether to get or set the configurations based on the input from the terminal
      #
      # @param output [IO]
      def execute(output: $stdout)
        options.each do |key, val|
          if val == key.to_s
            output.puts RubyEdit.config.send(key)
          else
            RubyEdit.config.send("#{key}=", val)
            output.puts "#{key.to_s.titleize} changed to #{val}"
          end
        end
      end

      private

      # Sanitizes the options hash to ensure only permitted values are processed
      def options
        @options = @options.select { |key, _val| CONFIGURATIONS.include?(key.to_sym) }
      end
    end
  end
end

