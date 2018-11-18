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
    # Display the current ruby-edit version [-v --version]
    #
    ## ruby-edit --version
    ## => 1.0.2
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
    # Set and view configuration options
    #
    ## # editor [-e --editor]
    ## ruby-edit configure --editor
    ## => vim
    ## ruby-edit configure --editor emacs
    ## => emacs
    ##
    ## # grep options [-o --grep_options]
    ## ruby-edit configure --grep_options
    ## => irn
    ## ruby-edit configure --grep_options h
    ## => Hn
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
    # text [-t --text]
    #
    # Performs a grep search based on given parameters, and puts all of the results into one file
    # to be edited.
    #
    ## # expression(required) [-e --expression]
    ## # path [-p --path] (defaults to *)
    def text(*)
      if options[:help]
        invoke :help, ['text']
      elsif options.empty?
        invoke :help
      else
        require_relative 'commands/text'
        RubyEdit::Commands::Text.new(options).execute
      end
    end

    map %w[--text -t] => :text

    desc 'file', 'Perform a find and edit the changes in one file'
    method_option :name, aliases: %w[-n --name], type: :string,
                         desc: 'The file / directory name', required: true
    method_option :type, aliases: %w[-t --type], type: :string,
                         desc: 'file [f, file] or directory [d, directory]'
    method_option :path, aliases: %w[-p --path], type: :string,
                         desc: 'the path you want to search'

    def file(*)
      if options[:help]
        invoke :help, ['file']
      elsif options.empty?
        invoke :help
      else
        require_relative 'commands/file'
        RubyEdit::Commands::File.new(options).execute
      end
    end
  end
end

