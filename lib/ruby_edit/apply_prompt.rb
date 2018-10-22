# frozen_string_literal: true

require 'ruby_edit/command'

module RubyEdit
  # Displays terminal prompts
  class ApplyPrompt < RubyEdit::Command
    # Displays 'are you sure' message defaulting to yes
    def continue?
      prompt.yes?('Do you want to apply these changes?')
    end
  end
end

