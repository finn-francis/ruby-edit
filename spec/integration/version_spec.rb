# frozen_string_literal: true

RSpec.describe '`ruby_edit version` command', type: :cli do
  let(:output) { `ruby-edit version` }

  it 'should display the current version' do
    expect(output).to include RubyEdit::VERSION

    expect(STDOUT).to receive(:puts).with("v#{RubyEdit::VERSION}")
    RubyEdit::CLI.new.version
  end
end

