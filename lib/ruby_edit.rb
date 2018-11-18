# frozen_string_literal: true

require 'ruby_extensions/string'
require 'ruby_edit/version'
require 'ruby_edit/configuration'

# Top level namespace
#
# All gem specific classes and modules are nested under this module
module RubyEdit
  SOURCE_FILE_LOCATION = ::File.expand_path('../temp/sourcefile', __dir__)
  CONFIGURATION_LOCATION = "#{__dir__}/../configuration".freeze

  class << self
    # Memoizes the configuration
    #
    # All configuration settings will reference this variable,
    # rather than instantiating a new Configuration instance
    def config
      @config ||= RubyEdit::Configuration.new
    end
  end
end

