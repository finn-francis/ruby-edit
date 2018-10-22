# frozen_string_literal: true

require 'tty/config'

module RubyEdit
  # Read and write ruby-edit configurations
  class Configuration
    # Creates a new TTY::Config instance, and loads in the current configuration from a yml file
    def initialize
      @config = TTY::Config.new
      @config.read("#{RubyEdit::CONFIGURATION_LOCATION}.yml")
    end

    # Fetches the default editor
    def editor
      @config.fetch(:editor) || 'vim'
    end

    # Sets the default editor
    #
    # @param editor [String]
    def editor=(editor)
      @config.set(:editor, value: editor)
      write
    end

    # Returns the default grep options
    def grep_options
      options = @config.fetch(:grep_options) || 'ir'
      # The n option is needed for edited changes to be applied, so it needs to be added here
      # automatically
      "#{options}n"
    end

    # Sets the default grep options
    #
    # @param grep_options [String]
    def grep_options=(grep_options)
      # All occurences of n are removed, as n is autamatically added when the options are fetched.
      @config.set(:grep_options, value: grep_options.delete('n'))
      write
    end

    # Resets back to defaults
    ## editor => vim
    ## grep_options => ir
    def reset_defaults
      @config.set(:editor, value: 'vim')
      @config.set(:grep_options, value: 'ir')
      write
    end

    private

    # Writes the configuration to the yml file
    #
    # This isn't the optimal way to do this (adding write at the end of each setter is annoying)
    # But I was having some trouble implementing the TTY::Config gem.
    # This is the best working solution i currently have.
    def write
      @config.write("#{RubyEdit::CONFIGURATION_LOCATION}.yml", force: true)
    end
  end
end

