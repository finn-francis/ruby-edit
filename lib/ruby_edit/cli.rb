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

    desc 'configure', 'set and read your settings'
    method_option :help, aliases: '-h', type: :boolean, desc: 'Display useage information'
    method_option :editor, aliases: %w[-e --editor], type: :string,
                           desc: 'Set or view your default text editor'
    def configure(*)
      if options[:help]
        invoke :help, ['configure']
      else
        require_relative 'commands/configure'
        RubyEdit::Commands::Configure.new(options).execute
      end
    end

    map %w[--configure -c] => :configure

    desc 'edit', '[Default] Perform a grep and edit the changes in one file'
    method_option :help, aliases: '-h', type: :boolean, desc: 'Display usage information'
    method_option :expression, aliases: %w[-e --expression], type: :string,
                               desc: 'the grep expression'
    method_option :path, aliases: %w[-p --path], type: :string, desc: 'the path you want to search'

    def edit(*)
      if options[:help]
        invoke :help, ['edit']
      elsif options.empty?
        invoke :help
      else
        require_relative 'commands/edit'
        RubyEdit::Commands::Edit.new(options).execute
      end
    end

    default_task :edit
  end
end

