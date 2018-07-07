# frozen_string_literal: true

require 'ruby_edit/grep'

module RubyEdit
  module Commands
    class Grep
      def initialize(options)
        @options = options
        @grep = RubyEdit::Grep.new(@options)
      end

      def execute(output: $stdout)
        @result = @grep.search
        output.puts 'OK'
      end
    end
  end
end

