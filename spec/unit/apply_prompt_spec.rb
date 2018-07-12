# frozen_string_literal: true

require 'tty/prompt'

RSpec.describe RubyEdit::ApplyPrompt do
  let(:prompt) { RubyEdit::ApplyPrompt.new }

  it 'should respond to #continue?' do
    expect_any_instance_of(TTY::Prompt).to receive(:yes?).and_return(true)
    expect(prompt.continue?).to be_truthy
  end
end

