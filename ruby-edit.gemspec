# frozen_string_literal: true

lib = File.expand_path('lib', __dir__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'ruby_edit/version'

Gem::Specification.new do |spec|
  spec.name          = 'ruby-edit'
  spec.license       = 'MIT'
  spec.version       = RubyEdit::VERSION
  spec.authors       = ['finn-francis']
  spec.email         = ['finnfrancis123@gmail.com']

  spec.summary       = 'Edit grep results in one file'
  spec.description   = 'Edit grep results in one file'
  spec.homepage      = 'https://github.com/finn-francis/ruby-edit'

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files = Dir.chdir(File.expand_path(__dir__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  end
  spec.bindir        = 'exe'
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']

  spec.add_dependency 'thor', '~> 0.20.0'
  spec.add_dependency 'tty-command', '~> 0.8.0'
  spec.add_dependency 'tty-config', '~> 0.2.0'
  spec.add_dependency 'tty-editor', '~> 0.4.0'
  spec.add_dependency 'tty-file', '~> 0.6.0'
  spec.add_dependency 'tty-prompt', '~> 0.16.1'

  spec.add_development_dependency 'bundler', '~> 1.16'
  spec.add_development_dependency 'pry-byebug'
  spec.add_development_dependency 'rake', '~> 13.0'
  spec.add_development_dependency 'rspec', '~> 3.0'
  spec.add_development_dependency 'simplecov'
end

