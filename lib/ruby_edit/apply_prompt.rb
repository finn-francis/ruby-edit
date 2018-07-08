# frozen_string_literal: true

require 'ruby_edit/command'

module RubyEdit
  class ApplyPrompt < RubyEdit::Command
    def continue?
      prompt.yes?('Do you want to apply these changes?')
    end
  end
end

