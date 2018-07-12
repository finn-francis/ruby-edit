# frozen_string_literal: true

require 'ruby_edit/command'

module RubyEdit
  class SourceFile < RubyEdit::Command
    def populate(content, **options)
      generator.create_file(RubyEdit::SOURCE_FILE_LOCATION, content, force: true, **options)
    end

    def delete(**options)
      generator.remove_file(RubyEdit::SOURCE_FILE_LOCATION, **options)
    end
  end
end

