# RubyEdit

ALPHA RELEASE

RubyEdit is a simple commandline app that allows you to edit grep results in one file.

## Installation

Run this line in your terminal:

```ruby
gem install ruby-edit
```

## Usage

### ruby-edit

Run:
```bash
ruby-edit -e my_expression -p ./path/to/file/
```

This will populate a tempfile with the grep results.

e.g.
```ruby
./path/to/file/file.rb:4:  my_expression('string')
./path/to/file/file.rb:10:    def my_expression(string)
./path/to/file/file_spec.rb:7: expect { my_expression('string') }.to do
```

Perform your edits and then save your file.

Warning:
Leave the path and line number alone, as this is used to find the respective file.
The space between the line number and your text is your indentation. Removing it will affect the indentation of your text.

You'll then be prompted in the console:

```bash
Do you want to apply these changes? (Y/n)
```

Selecting 'Y' will insert your changes into their respective files.

### configure

Run:
```bash
ruby-edit configure -e my_editor
```

This will set your default editor.
Pass the command you use to start your editor, NOT the name of the editor.
For example: if you use Sublime Text send `subl` not `Sublime Text`

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/finn-francis/ruby-edit. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.

## Code of Conduct

Everyone interacting in the RubyEdit project’s codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/[USERNAME]/ruby-edit/blob/master/CODE_OF_CONDUCT.md).

## Copyright

Copyright (c) 2018 finn-francis. See [MIT License](LICENSE.txt) for further details.
