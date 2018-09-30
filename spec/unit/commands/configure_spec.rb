# frozen_string_literal: true

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

    context 'viewing the grep_options' do
      let(:options) { { grep_options: 'grep_options' } }

      it 'should display the default grep_options' do
        command.execute(output: output)
        expect(output.string).to eq "irn\n"
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
        expect { command.execute(output: output) }.to change { RubyEdit.config.editor }.to 'nano'
      end
    end

    context 'changing the grep_options' do
      let(:options) { { grep_options: 'al' } }
      after { RubyEdit.config.reset_defaults }

      it 'should display the new grep_options' do
        command.execute(output: output)
        expect(output.string).to eq "Grep options changed to al\n"
      end

      it 'should change the default grep_options' do
        expect do
          command.execute(output: output)
        end.to change { RubyEdit.config.grep_options }.to 'aln'
      end
    end
  end
end

