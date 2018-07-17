# frozen_string_literal: true

require 'tty/command'

RSpec.describe RubyEdit::Commands::Grep do
  let(:output) { StringIO.new }
  let(:options) { { path: '.', expression: 'TEXT_TO_CHANGE' } }
  let(:command) { RubyEdit::Commands::Grep.new(options) }

  before do
    stub_const 'RubyEdit::SOURCE_FILE_LOCATION', 'spec/support/sourcefile'
    allow_any_instance_of(RubyEdit::Command)
      .to(receive(:command).and_return(TTY::Command.new(printer: :null)))
  end

  describe '#execute' do
    it 'executes `grep` command successfully' do
      command.execute(output: output)
      expect(output.string).to include("OK\n")
    end
  end
end

