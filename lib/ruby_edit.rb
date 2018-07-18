# frozen_string_literal: true

require 'ruby_extensions/string'
require 'ruby_edit/version'
require 'ruby_edit/configuration'

module RubyEdit
  SOURCE_FILE_LOCATION = File.expand_path('../temp/sourcefile', __dir__)
  CONFIGURATION_LOCATION = "#{__dir__}/../configuration"

  class << self
    def config
      @config ||= RubyEdit::Configuration.new
    end
  end
end

