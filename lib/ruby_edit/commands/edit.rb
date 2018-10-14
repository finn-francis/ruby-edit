# frozen_string_literal: true

require 'ruby_edit'
require 'ruby_edit/apply_prompt'
require 'ruby_edit/editor'
require 'ruby_edit/text/grep'
require 'ruby_edit/source_file'
require 'ruby_edit/text/writer'

module RubyEdit
  module Commands
    class Edit
      def initialize(options)
        @grep       = RubyEdit::Text::Grep.new(options)
        @sourcefile = RubyEdit::SourceFile.new
        @editor     = RubyEdit::Editor.new
        @output     = $stdout
        @errors     = $stderr
      end

      def execute
        return unless grep_search
        populate_sourcefile
        edit_file
        apply_changes if apply_changes?
        delete_sourcefile
      end

      private

      def grep_search
        @grep.search(output: @output, errors: @errors)
      end

      def populate_sourcefile
        @sourcefile.populate(@grep.result.out)
      end

      def edit_file
        @editor.edit_sourcefile
      end

      def apply_changes?
        RubyEdit::ApplyPrompt.new.continue?
      end

      def apply_changes
        RubyEdit::Text::Writer.new.write
      end

      def delete_sourcefile
        @sourcefile.delete
      end
    end
  end
end

