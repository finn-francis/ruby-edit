# frozen_string_literal: true

require 'tty/config'

module RubyEdit
  class Configuration
    LOCATION = 'configuration'

    def initialize
      @config          = TTY::Config.new
      @config.filename = LOCATION
      @config.read("#{LOCATION}.yml")
    end

    def editor
      @config.fetch(:editor).to_sym
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
      @config.write
    end
  end
end

