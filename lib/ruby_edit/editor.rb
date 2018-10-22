# frozen_string_literal: true

require 'ruby_edit/command'

module RubyEdit
  # Text editor
  #
  # Inherits from RubyEdit::Command to gain access to the TTY editor functionality
  class Editor < RubyEdit::Command
    def initialize
      @config = RubyEdit.config
    end

    # Opens the sourcefile using the users default text editor
    def open_sourcefile
      editor.open RubyEdit::SOURCE_FILE_LOCATION, command: @config.editor
    end
  end
end

