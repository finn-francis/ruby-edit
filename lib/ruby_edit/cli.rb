# frozen_string_literal: true

require 'thor'

module RubyEdit
  # Handle the application command line parsing
  # and the dispatch to various command objects
  #
  # @api public
  class CLI < Thor
    # Error raised by this runner
    Error = Class.new(StandardError)

    desc 'version', 'ruby-edit version'
    def version
      require_relative 'version'
      puts "v#{RubyEdit::VERSION}"
    end
    map %w[--version -v] => :version

    desc 'grep', 'search for an expression in your directory'
    method_option :help, aliases: '-h', type: :boolean, desc: 'Display usage information'
    method_option :expression, aliases: %w[-e --expression], type: :string,
                               desc: 'the grep expression'
    method_option :path, aliases: %w[-p --path], type: :string, desc: 'the path you want to search'
    def grep(*)
      if options[:help]
        invoke :help, ['grep']
      else
        require_relative 'commands/grep'
        RubyEdit::Commands::Grep.new(options).execute
      end
    end

    map %w[--grep -g] => :grep
  end
end

