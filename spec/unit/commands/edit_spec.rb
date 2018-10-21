# frozen_string_literal: true

require 'tty/editor'
require 'tty/command'

RSpec.describe RubyEdit::Commands::Edit do
  # TODO: This needs cleaning up!
  let(:output) { StringIO.new }
  let(:options) { { path: '.', expression: 'TEXT_TO_CHANGE' } }
  let(:command) do
    RubyEdit::Commands::Edit.new(options).tap do |edit|
      edit.instance_variable_set('@output', output)
    end
  end
  let(:generator) { RubyEdit::Command.new.generator }

  before do
    stub_const 'RubyEdit::SOURCE_FILE_LOCATION', 'spec/support/sourcefile'
    allow_any_instance_of(RubyEdit::Command)
      .to(receive(:command).and_return(TTY::Command.new(printer: :null)))
  end
  after do
    generator.copy_directory('spec/support/test_directory', 'spec/support/temp_directory',
                             force: true, verbose: false)
    generator.copy_file('spec/support/sourcefile_template', 'spec/support/sourcefile',
                        force: true, verbose: false)
  end

  it 'executes edit successfully' do
    expect(TTY::Editor).to receive(:open).and_return(true)
    expect_any_instance_of(RubyEdit::SourceFile).to receive(:delete).and_return(true)
    expect_any_instance_of(TTY::Prompt).to receive(:yes?).and_return(true)
    expect_any_instance_of(RubyEdit::Text::Writer).to receive(:write).and_return(true)
    # expect_any_instance_of(RubyEdit::Commands::Edit).to receive(:apply_changes).and_return(true)
    expect(command.execute).to be_truthy
  end
end

