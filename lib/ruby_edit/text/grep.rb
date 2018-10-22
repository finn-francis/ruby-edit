# frozen_string_literal: true

require 'ruby_edit/command'

module RubyEdit
  module Text
    # Performs and saves the results of a grep command
    class Grep < RubyEdit::Command
      attr_reader :result

      # @param options [Hash]
      def initialize(options)
        # Default the path to '*', as this is probably the most common path for a recursive search
        @path       = options[:path] || '*'
        @expression = options[:expression]
        @config     = RubyEdit.config
      end

      # Performs the grep search unless no expression provided
      #
      # @param output [IO]
      #
      # @param errors [IO]
      def search(output: $stdout, errors: $stderr)
        if empty_expression?
          output.puts 'No expression given'
          return false
        end
        @result = run "grep -#{@config.grep_options} #{@path} -e '#{@expression}'" do |out, err|
          errors << err if err
        end
      rescue TTY::Command::ExitError => error
        output.puts error
      end

      private

      def empty_expression?
        @expression.nil? || @expression.empty?
      end
    end
  end
end
