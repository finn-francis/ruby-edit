# frozen_string_literal: true

RSpec.describe RubyEdit::ApplyPrompt do
  let(:prompt) { RubyEdit::ApplyPrompt.new }

  it 'should respond to #continue?' do
    expect(prompt).to respond_to :continue?
    expect(prompt).to receive(:continue?)
    prompt.continue?
  end
end

