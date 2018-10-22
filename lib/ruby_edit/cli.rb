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

    desc 'configure', 'set and read your settings'
    method_option :help, aliases: '-h', type: :boolean, desc: 'Display useage information'
    method_option :editor, aliases: %w[-e --editor], type: :string,
                           desc: 'Set or view your default text editor'
    method_option :grep_options, aliases: %w[-o --grep-options], type: :string,
                                 description: 'default grep options to refine your searches'
    def configure(*)
      if options[:help]
        invoke :help, ['configure']
      else
        require_relative 'commands/configure'
        RubyEdit::Commands::Configure.new(options).execute
      end
    end

    map %w[--configure -c] => :configure

    desc 'text', 'Perform a grep and edit the changes in one file'
    method_option :expression, aliases: %w[-e --expression], type: :string,
                               desc: 'the grep expression', required: true
    method_option :path, aliases: %w[-p --path], type: :string, desc: 'the path you want to search'
    def text(*)
      if options[:help]
        invoke :help, ['text']
      elsif options.empty?
        invoke :help
      else
        require_relative 'commands/edit'
        RubyEdit::Commands::Edit.new(options).execute
      end
    end

    map %w[--text -t] => :text
  end
end

