# frozen_string_literal: true

RSpec.describe RubyEdit::SourceFile do
  let(:sourcefile) { RubyEdit::SourceFile.new }
  let(:location) { RubyEdit::SOURCE_FILE_LOCATION }
  let(:content) { 'FILE CONTENT' }

  after { File.delete(location) if File.exist?(location) }

  describe '#populate' do
    it 'should create a file in temp' do
      expect do
        sourcefile.populate(content)
      end.to change { File.exist?(location) }.to true
    end

    it 'should add content to the created file' do
      sourcefile.populate(content)
      expect(File.read(location)).to eq content
    end
  end

  describe '#delete' do
    before { sourcefile.populate(content) }

    it 'should delete the file' do
      expect do
        sourcefile.delete
      end.to change { File.exist?(location) }.to false
    end
  end
end

