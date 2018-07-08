# frozen_string_literal: true

require 'ruby_edit/version'
require 'ruby_edit/configuration'

module RubyEdit
  SOURCE_FILE_LOCATION = 'temp/sourcefile'

  class << self
    def config
      @config ||= RubyEdit::Configuration.new
    end
  end
end

