# frozen_string_literal: true

require 'tty/config'

module RubyEdit
  class Configuration
    def initialize
      @config = TTY::Config.new
      @config.read("#{RubyEdit::CONFIGURATION_LOCATION}.yml")
    end

    def editor
      @config.fetch(:editor) || 'vim'
    end

    def editor=(editor)
      @config.set(:editor, value: editor)
      write
    end

    def grep_options
      options = @config.fetch(:grep_options) || 'ir'
      # The n option is needed for edited changes to be applied, so it needs to be added here
      # automatically
      "#{options}n"
    end

    def grep_options=(grep_options)
      # All occurences of n are removed, as n is autamatically added when the options are fetched.
      @config.set(:grep_options, value: grep_options.gsub('n', ''))
      write
    end

    def reset_defaults
      @config.set(:editor, value: 'vim')
      @config.set(:grep_options, value: 'ir')
      write
    end

    private

    def write
      @config.write("#{RubyEdit::CONFIGURATION_LOCATION}.yml", force: true)
    end
  end
end

