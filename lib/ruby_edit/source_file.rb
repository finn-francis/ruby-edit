# frozen_string_literal: true

require 'ruby_edit/command'

module RubyEdit
  class SourceFile < RubyEdit::Command
    def populate(content)
      generator.create_file(RubyEdit::SOURCE_FILE_LOCATION, content)
    end

    def delete
      generator.remove_file(RubyEdit::SOURCE_FILE_LOCATION)
    end
  end
end

