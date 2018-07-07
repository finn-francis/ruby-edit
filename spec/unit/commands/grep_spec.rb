# frozen_string_literal: true

require 'ruby_edit/commands/grep'

RSpec.describe RubyEdit::Commands::Grep do
  let(:output) { StringIO.new }
  let(:options) { { path: '.', expression: 'initialize' } }
  let(:command) { RubyEdit::Commands::Grep.new(options) }

  describe '#execute' do
    it 'executes `grep` command successfully' do
      command.execute(output: output)
      expect(output.string).to eq("OK\n")
    end
  end
end

