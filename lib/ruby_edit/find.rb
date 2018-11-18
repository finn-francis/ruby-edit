# frozen_string_literal: true

require 'ruby_edit/command'

module RubyEdit
  # Performs and saves the result of a the find command
  class Find < RubyEdit::Command
    attr_reader :result

    def initialize(options)
      @name   = options[:name]
      @type   = options[:type]
      @path   = options[:path] || '.'
      @config = RubyEdit.config
    end

    # Performs the find unless no name provided
    #
    # @param output [IO]
    #
    # @param errors [IO]
    def execute(output: $stdout, errors: $stderr)
      if empty_name?
        output.puts 'No name given'
        return false
      end
      result = run "find #{@path} #{type} -name '#{@name}'" do |_out, err|
        errors << err if err
      end
      # The following line makes the output into something readable
      #
      # Before the output would have looked like this:
      ## ./lib/my_file.rb
      ## ./lib/folder/my_file.rb
      #
      # Whereas it will now look like this:
      ## ./lib/my_file.rbi NEW_NAME=> ./lib/my_file.rb
      ## ./lib/folder/my_file.rb NEW_NAME=> ./lib/folder/my_file.rb
      #
      # Making it more obvious that the original path is on the left
      # and the path to edit is on the right
      @result = result.out.split("\n").map { |path| "#{path} NEW_NAME=> #{path}" }.join("\n")
    rescue TTY::Command::ExitError => error
      output.puts error
    end

    private

    def empty_name?
      @name.nil? || @name.empty?
    end

    def type
      @type.nil? || @type.empty? ? '' : "-type #{@type}"
    end
  end
end

