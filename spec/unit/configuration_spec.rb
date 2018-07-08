# frozen_string_literal: true

require 'ruby_edit/configuration'

RSpec.describe RubyEdit::Configuration do
  let(:config) { RubyEdit::Configuration.new }
  after { config.reset_defaults }

  describe RubyEdit::Configuration::LOCATION do
    it 'should return the location of the configuration yaml file' do
      expect(RubyEdit::Configuration::LOCATION).to include 'configuration'
    end
  end

  context 'configuration is loaded for the first time' do
    it 'should load the default values' do
      expect(config.editor).to eq :vim
    end
  end

  describe '#reset_defaults' do
    before { config.editor = :nano }

    it 'should set the config back to default' do
      expect { config.reset_defaults }.to change { config.editor }.to :vim
    end
  end

  describe '#editor' do
    it 'should return the editor' do
      expect(config.editor).to eq :vim
    end
  end

  describe '#editor=' do
    it 'should change the default editor' do
      expect { config.editor = :nano }.to change { config.editor }.to :nano
    end
  end
end

