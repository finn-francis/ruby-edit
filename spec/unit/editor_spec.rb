# frozen_string_literal: true

RSpec.describe RubyEdit::Editor do
  let(:editor) { RubyEdit::Editor.new }

  after do
    File.delete(RubyEdit::SOURCE_FILE_LOCATION) if File.exist?(RubyEdit::SOURCE_FILE_LOCATION)
  end

  describe '#edit_sourcefile' do
    it 'should open the sourcefile in an editor' do
      expect(editor).to receive(:edit_sourcefile)
      editor.edit_sourcefile
      expect(editor).to respond_to :edit_sourcefile
    end
  end
end

