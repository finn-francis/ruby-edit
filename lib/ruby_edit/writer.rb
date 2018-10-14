# frozen_string_literal: true

require 'fileutils'
require 'tempfile'
require 'ruby_edit/command'

module RubyEdit
  class Writer < RubyEdit::Command
    LINE_REGEX = /^.*:\d+:/

    def write
      File.open(RubyEdit::SOURCE_FILE_LOCATION, 'rb') do |file|
        file.each_line { |line| find_and_replace_line line }
      end
    end

    private

    def find_and_replace_line(new_line)
      @temp_file = Tempfile.new('temp_file')
      split_file_and_line(new_line)
      @new_line = new_line.sub LINE_REGEX, ''
      begin
        replace_line
        replace_file
      ensure
        @temp_file.close
        @temp_file.unlink
      end
    end

    def split_file_and_line(line)
      @file_name, @line_number = line.match(LINE_REGEX)[0].split(':')
    rescue NoMethodError
      false
    end

    # Replaces the line in the original file, with the line from the sourcefile
    def replace_line
      File.open(@file_name, 'r+') do |file|
        # Using this method instead of each_with_index for performance increase
        index = 1
        file.each do |line|
          output = index == @line_number.to_i ? @new_line : line
          @temp_file.puts output
          index += 1
        end
      end
    end

    # Replaces the old file, with the new edited file
    def replace_file
      @temp_file.close
      FileUtils.mv(@temp_file.path, @file_name)
    end
  end
end

