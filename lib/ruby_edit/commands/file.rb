# frozen_string_literal: true

require 'ruby_edit'
require 'ruby_edit/apply_prompt'
require 'ruby_edit/editor'
require 'ruby_edit/find'
require 'ruby_edit/source_file'
require 'ruby_edit/file/writer'

module RubyEdit
  module Commands
    # File command class
    #
    # Gets called from the CLI text method and handles file edits
    class File
      # Gathers all the classes needed to perform a file edit
      #
      # @param options [Hash]
      def initialize(options)
        @find       = RubyEdit::Find.new(options)
        @sourcefile = RubyEdit::SourceFile.new
        @editor     = RubyEdit::Editor.new
        @output     = $stdout
        @errors     = $stderr
      end

      # Executes all of the methods needed to perform a file edit
      def execute
        return unless find

        populate_sourcefile
        edit_file
        apply_changes if apply_changes?
        delete_sourcefile
      end

      private

      # Performs the find with the options passed in from the CLI
      def find
        @find.execute(output: @output, errors: @errors)
      end

      # Creates the sourcefile for editing, to be populated with the results from the find
      def populate_sourcefile
        @sourcefile.populate(@find.result)
      end

      # Opens the sourcefile containing the find results, with the users default text editor
      def edit_file
        @editor.open_sourcefile
      end

      # Perform a check to ensure that the user wants to save the edits made
      def apply_changes?
        RubyEdit::ApplyPrompt.new.continue?
      end

      # Writes the edits made in the sourcefile back to the respective files
      def apply_changes
        RubyEdit::File::Writer.new.write
      end

      def delete_sourcefile
        @sourcefile.delete
      end
    end
  end
end

