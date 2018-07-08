# frozen_string_literal: true

require 'ruby_edit'
require 'ruby_edit/writer'

RSpec.describe RubyEdit::Writer do
  let(:writer) { RubyEdit::Writer.new }
  let(:generator) { RubyEdit::Command.new.generator }
  before do
    stub_const 'RubyEdit::SOURCE_FILE_LOCATION', 'spec/support/sourcefile'
    generator.copy_directory('spec/support/test_directory', 'spec/support/temp_directory',
                             force: true)
  end

  describe '#write' do
    let(:file1) { 'spec/support/temp_directory/file1.txt' }
    let(:file2) { 'spec/support/temp_directory/file2.txt' }

    it 'should write all the changes to the sourcefile' do
      expect(File.read(file1)).to include 'TEXT_TO_CHANGE'
      expect(File.read(file2)).to include 'TEXT_TO_CHANGE'
      expect(File.read(file1)).to_not include 'CHANGED_TEXT'
      expect(File.read(file2)).to_not include 'CHANGED_TEXT'

      writer.write

      expect(File.read(file1)).to include 'CHANGED_TEXT'
      expect(File.read(file2)).to include 'CHANGED_TEXT'
      expect(File.read(file1)).to_not include 'TEXT_TO_CHANGE'
      expect(File.read(file2)).to_not include 'TEXT_TO_CHANGE'
    end
  end
end

