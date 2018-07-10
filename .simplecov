SimpleCov.start do
  add_filter '/spec/'
  add_filter 'lib/ruby_edit/command.rb'
  add_group 'Commands', 'lib/ruby_edit/commands'
end

