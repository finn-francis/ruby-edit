# frozen_string_literal: true

require 'ruby_edit/command'

module RubyEdit
  class Editor < RubyEdit::Command
    def edit_sourcefile
      # TODO: the command option needs to be dynamic once user config has been set up
      editor.open(RubyEdit::SOURCE_FILE_LOCATION, command: :vim)
    end
  end
end

