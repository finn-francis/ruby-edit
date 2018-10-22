# frozen_string_literal: true

require 'tty/editor'

RSpec.describe RubyEdit::Editor do
  let(:editor) { RubyEdit::Editor.new }

  after do
    File.delete(RubyEdit::SOURCE_FILE_LOCATION) if File.exist?(RubyEdit::SOURCE_FILE_LOCATION)
  end

  describe '#open_sourcefile' do
    it 'should open the sourcefile in an editor' do
      expect(TTY::Editor).to receive(:open).and_return(true)
      expect(editor.open_sourcefile).to be_truthy
    end
  end
end

