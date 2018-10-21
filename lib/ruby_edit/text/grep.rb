# frozen_string_literal: true

require 'ruby_edit/command'

module RubyEdit
  module Text
    class Grep < RubyEdit::Command
      attr_reader :result

      def initialize(options)
        @path       = options[:path] || '*'
        @expression = options[:expression]
        @config     = RubyEdit.config
      end

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
