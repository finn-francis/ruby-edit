# frozen_string_literal: true

require 'ruby_edit/commands/configure'

RSpec.describe RubyEdit::Commands::Configure do
  let(:output) { StringIO.new }
  let(:command) { RubyEdit::Commands::Configure.new(options) }

  describe '#execute' do
    context 'viewing the editor' do
      let(:options) { { editor: 'editor' } }

      it 'should display the current editor' do
        command.execute(output: output)
        expect(output.string).to eq "vim\n"
      end
    end

    context 'changing the editor' do
      let(:options) { { editor: 'nano' } }
      after { RubyEdit.config.reset_defaults }

      it 'should display the new editor' do
        command.execute(output: output)
        expect(output.string).to eq "Editor changed to nano\n"
      end

      it 'should change the default editor' do
        expect { command.execute(output: output) }.to change { RubyEdit.config.editor }.to :nano
      end
    end
  end
end

