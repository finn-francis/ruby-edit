# frozen_string_literal: true

RSpec.describe RubyEdit do
  it 'has a version number' do
    expect(RubyEdit::VERSION).not_to be nil
  end

  describe 'LOCATION' do
    it 'should specify the location' do
      expect(RubyEdit::SOURCE_FILE_LOCATION).to include 'temp/sourcefile'
    end
  end

  describe RubyEdit::CONFIGURATION_LOCATION do
    it 'should return the location of the configuration yaml file' do
      expect(RubyEdit::CONFIGURATION_LOCATION).to include 'configuration'
    end
  end

  describe '#config' do
    it 'should have a config' do
      expect(RubyEdit.config).to be_a RubyEdit::Configuration
    end
  end
end

