# frozen_string_literal: true

require 'tty/config'

module RubyEdit
  class Configuration
    def initialize
      @config = TTY::Config.new
      @config.read("#{RubyEdit::CONFIGURATION_LOCATION}.yml")
    end

    def editor
      @config.fetch(:editor)&.to_sym || :vim
    end

    def editor=(editor)
      @config.set(:editor, value: editor.to_s)
      write
    end

    def reset_defaults
      @config.set(:editor, value: 'vim')
      write
    end

    private

    def write
      @config.write("#{RubyEdit::CONFIGURATION_LOCATION}.yml", force: true)
    end
  end
end

