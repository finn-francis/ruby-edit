# frozen_string_literal: true

require 'ruby_edit'

module RubyEdit
  module Commands
    class Configure
      def initialize(options)
        @options = options
      end

      def execute(output: $stdout)
        # This may need to be made dynamic if more configuration options are added
        if editor == 'editor'
          output.puts RubyEdit.config.editor
        else
          RubyEdit.config.editor = editor
          output.puts "Editor changed to #{editor}"
        end
      end

      private

      def editor
        @options[:editor]
      end
    end
  end
end

