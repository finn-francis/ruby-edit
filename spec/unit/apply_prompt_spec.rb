# frozen_string_literal: true

require 'ruby_edit/apply_prompt'

RSpec.describe RubyEdit::ApplyPrompt do
  let(:prompt) { RubyEdit::ApplyPrompt.new }

  it 'should respond to #continue?' do
    expect(prompt).to respond_to :continue?
    expect(prompt).to receive(:continue?)
    prompt.continue?
  end
end

