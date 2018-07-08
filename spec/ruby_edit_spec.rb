# frozen_string_literal: true

RSpec.describe RubyEdit do
  it 'has a version number' do
    expect(RubyEdit::VERSION).not_to be nil
  end

  describe 'LOCATION' do
    it 'should specify the location' do
      expect(RubyEdit::SOURCE_FILE_LOCATION).to eq 'temp/sourcefile'
    end
  end
end

