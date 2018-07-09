# frozen_string_literal: true

RSpec.describe RubyEdit::Grep do
  let(:grep) { RubyEdit::Grep.new(options) }
  let(:options) { { path: '.', expression: 'initialize' } }
  let(:output) { StringIO.new }

  describe '#search' do
    it 'should have a getter for result' do
      expect(grep).to respond_to :result
    end

    it 'should perform a grep search' do
      search = grep.search
      expect(search).to be_a TTY::Command::Result
      expect(search.out).to_not be_empty
    end

    context "it doesn't return any matches" do
      let(:options) { { path: './lib/', expression: 'NON-EXISTING-STRING' } }

      it 'should not error out' do
        expect { grep.search }.to_not raise_error
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

