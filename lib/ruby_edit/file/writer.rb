# frozen_string_literal: true

module RubyEdit
  module File
    # Handles the writing of file and directory name edits
    class Writer < RubyEdit::Command
      # Opens the sourcefile in a block to ensure it will be closed correctly, and renames all of
      # the files / directories with their new values
      def write
        ::File.open(RubyEdit::SOURCE_FILE_LOCATION, 'rb') do |file|
          file.each_line { |line| find_and_rename_file(line) }
        end
      end

      private

      # Splits the line on NEW_NAME=> (which is the old / new filename seperator)
      # and then renames the old name to the new name e.g.
      #
      ## line = './directory/my_file.rb NEW_NAME=> ./directory/my_new_file.rb'
      ## => ['.directory/my_file.rb ', ' ./directory/my_new_file']
      #
      # @param line [String]
      def find_and_rename_file(line)
        old_file, new_file = line.split('NEW_NAME=>')
        run "mv #{old_file} #{new_file}"
      end
    end
  end
end

