# frozen_string_literal: true

require 'ruby_edit/command'

module RubyEdit
  # Creates and manages the sourcefile, for performing edits
  #
  # Inherits from RubyEdit::Command to access the TTY command functionality
  class SourceFile < RubyEdit::Command
    # Populates the sourcefile with the given content
    #
    # @param content [String] - Usually the output of a bash command
    #
    # @param **options [key value pairs] -
    # See https://github.com/piotrmurach/tty-file for TTY::File docs
    def populate(content, **options)
      generator.create_file(RubyEdit::SOURCE_FILE_LOCATION, content, force: true, **options)
    end

    # Deletes the sourcefile
    #
    # @param **options [key value pairs] -
    # See https://github.com/piotrmurach/tty-file for TTY::File docs
    def delete(**options)
      generator.remove_file(RubyEdit::SOURCE_FILE_LOCATION, **options)
    end
  end
end

