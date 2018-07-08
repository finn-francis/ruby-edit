# frozen_string_literal: true

require 'ruby_edit/command'

module RubyEdit
  class Editor < RubyEdit::Command
    def initialize
      @config = RubyEdit.config
    end

    def edit_sourcefile
      editor.open RubyEdit::SOURCE_FILE_LOCATION, command: @config.editor
    end
  end
end

