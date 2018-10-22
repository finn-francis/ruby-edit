# frozen_string_literal: true

require 'fileutils'
require 'tempfile'
require 'ruby_edit/command'

module RubyEdit
  module Text
    # Handles the writing of text edits back into their respective files
    class Writer < RubyEdit::Command
      # Matches everything from the beginning of the line up to a colon,
      # followed by any number of digits and another colon
      LINE_REGEX = /^.*:\d+:/

      # Opens the file for writing in a block to ensure it will always be closed properly,
      # and sends of each line to be processed and written
      def write
        File.open(RubyEdit::SOURCE_FILE_LOCATION, 'rb') do |file|
          file.each_line { |line| find_and_replace_line line }
        end
      end

      private

      # Finds the file to be changed, and inserts the new line
      #
      # @param new_line [String]
      def find_and_replace_line(new_line)
        # Creates a tempfile for writing, this will be the edited version of the real file
        # and will end up replacing the original file
        @temp_file = Tempfile.new('temp_file')
        # If split_file_and_line fails, we return, and move on to the next line
        return unless split_file_and_line(new_line)

        @new_line = new_line.sub LINE_REGEX, ''
        begin
          replace_line
          replace_file
        ensure
          # Ensure all files get closed and unlinked
          @temp_file.close
          @temp_file.unlink
        end
      end

      # Using the regex in LINE_REGEX, this method matches the file path and line number,
      # splits them, and returns them in an array e.g.
      #
      ## line = '/usr/home/my_file.rb:12:'
      ## split_file_and_line(line)
      ## => ['/usr/home/my_file.rb', '12']
      #
      # @param line [String]
      def split_file_and_line(line)
        match = line.match(LINE_REGEX)
        return unless match

        @file_name, @line_number = match[0].split(':')
      end

      # Replaces the line in the original file, with the line from the sourcefile
      def replace_line
        File.open(@file_name, 'r+') do |file|
          # Using file.each instead of each_with_index for performance increase
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
        # Moves the tempfile with the edits, into the path of the original file,
        # effectively replacing the original
        FileUtils.mv(@temp_file.path, @file_name)
      end
    end
  end
end

