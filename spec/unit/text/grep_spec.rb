# frozen_string_literal: true

require 'tty/command'

RSpec.describe RubyEdit::Text::Grep do
  let(:grep) { RubyEdit::Text::Grep.new(options) }
  let(:options) { { path: '.', expression: 'TEXT_TO_CHANGE' } }
  let(:output) { StringIO.new }

  before do
    stub_const 'RubyEdit::SOURCE_FILE_LOCATION', 'spec/support/sourcefile'
    allow_any_instance_of(RubyEdit::Command)
      .to(receive(:command).and_return(TTY::Command.new(printer: :null)))
  end

  describe '#search' do
    it 'should have a getter for result' do
      expect(grep).to respond_to :result
    end

    it 'should perform a grep search' do
      search = grep.search(output: output)
      expect(search).to be_a TTY::Command::Result
      expect(search.out).to_not be_empty
    end

    context "it doesn't return any matches" do
      let(:options) { { path: './lib/', expression: 'NON-EXISTING-STRING' } }

      it 'should not error out' do
        expect { grep.search(output: output) }.to_not raise_error
      end

      it 'should print the error' do
        grep.search(output: output)
        expect(output.string).to include 'exit status: 1'
      end
    end

    context 'no expression is given' do
      let(:options) { { path: '.', expression: nil } }

      it 'should print a warning' do
        grep.search(output: output)
        expect(output.string).to eq "No expression given\n"
      end
    end
  end
end

