# sss_script_tools

This repo contains some Ruby libraries and commandline tools for working with the script files from Lunar: Silver Star Story for Saturn.

It's still a work in progress, but it recognizes the most common subroutines and control codes and is able to parse the Japanese script files.

## Installation

Within this repo, run:

```
rake build
gem install pkg/*.gem
```

Or run it from within the repo by running the files in `exe` like this:

```
ruby -I . exe/script_printer path_to_script
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/studio-lucia/sss_script_tools. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.
