# frozen_string_literal: true

RSpec.describe '`ruby_edit grep` command', type: :cli do
  let(:output) { `ruby-edit grep -e initialize` }

  it 'should run the grep command' do
    expect(output).to include('initialize', 'OK')
  end

  describe 'help' do
    let(:output) { `ruby-edit help grep` }
    let(:usage) do
      "Usage:\n  ruby-edit grep"
    end
    let(:help) { '-h, [--help], [--no-help]' }
    let(:expression) { '-e, --expression, --expression=EXPRESSION' }
    let(:path) { '-p, --path, [--path=PATH]' }

    it 'should execute the `ruby-edit help grep` command successfully' do
      expect(output).to include(usage, expression, path)
    end
  end
end

