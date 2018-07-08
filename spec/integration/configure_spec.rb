# frozen_string_literal: true

RSpec.describe '`ruby_edit configure` command', type: :cli do
  describe 'viewing the default editor' do
    let(:output) { `ruby-edit configure -e` }

    it 'should display the current editor' do
      expect(output).to eq("vim\n")
    end
  end

  describe 'changing the default editor' do
    let(:output) { `ruby-edit configure -e nano` }
    after { RubyEdit.config.reset_defaults }

    it 'should display the new editor' do
      expect(output).to eq "Editor changed to nano\n"
    end
  end

  describe 'help' do
    let(:output) { `ruby-edit help configure` }
    let(:usage) do
      "Usage:\n  ruby-edit configure"
    end
    let(:help) { '-h, [--help], [--no-help]' }
    let(:editor) { 'Set or view your default text editor' }

    it 'should execute the `ruby-edit help grep` command successfully' do
      expect(output).to include(usage, help, editor)
    end
  end
end

