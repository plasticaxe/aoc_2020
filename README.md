# Aoc2020

Solutions created for https://adventofcode.com/2020 in the guise of a gem for no particular reason.

## Development

After checking out the repo, run `bin/setup` to install all runtime and development dependencies. Then, run `rake spec` to run the rspec and rubocop tests. 
You can also run `bin/console` for an interactive prompt that will allow you to experiment.

## Installation

To install this gem onto your local machine, run `bundle exec rake install` after you have set up for development.

## Usage

    $ aoc_2020 --day <day> [--input-file <path to input file>]
    
Without specifying an input file it will generate solutions based on my personal input data from Advent of Code 2020. This may be useful for testing any changes.

#### There is no target for release at this time, ignore the following...
To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/plasticaxe/aoc_2020. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [code of conduct](https://github.com/[USERNAME]/aoc_2020/blob/master/CODE_OF_CONDUCT.md).

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the Aoc2020 project's codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/plasticaxe/aoc_2020/blob/master/CODE_OF_CONDUCT.md).
