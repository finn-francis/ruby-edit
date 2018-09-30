# frozen_string_literal: true

RSpec.describe RubyEdit::Configuration do
  let(:config) { RubyEdit::Configuration.new }
  before do
    # TODO: This needs to be tested properly
    expect_any_instance_of(TTY::Config)
      .to(receive(:read).and_return('editor' => 'vim', grep_options: 'ir'))
  end
  after { config.reset_defaults }

  context 'configuration is loaded for the first time' do
    it 'should load the default values' do
      expect(config.editor).to eq 'vim'
      expect(config.grep_options).to eq 'irn'
    end
  end

  describe '#reset_defaults' do
    before { config.editor = 'nano' }
    before { config.grep_options = '' }

    it 'should set the editor back to default' do
      expect { config.reset_defaults }.to change { config.editor }.to 'vim'
    end

    it 'should set the grep_options back to default' do
      expect { config.reset_defaults }.to change { config.grep_options }.to 'irn'
    end
  end

  describe '#editor' do
    it 'should return the editor' do
      expect(config.editor).to eq 'vim'
    end
  end

  describe '#editor=' do
    it 'should change the default editor' do
      expect { config.editor = 'nano' }.to change { config.editor }.to 'nano'
    end
  end

  describe '#grep_options' do
    it 'should return the grep_options' do
      expect(config.grep_options).to eq 'irn'
    end
  end

  describe '#grep_options=' do
    it 'should change the default grep_options' do
      expect { config.grep_options = '' }.to change { config.grep_options }.to 'n'
    end
  end
end

