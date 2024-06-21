# RSignals

RSignals is a reactive signal gem for ruby. Create reactivity with your variables.


## Installation

Install the gem and add to the application's Gemfile by executing:

    $ bundle add r_signals

If bundler is not being used to manage dependencies, install the gem by executing:

    $ gem install r_signals

## Usage

### First extend the module
    ```
        include RSignals::RSignalable
    ```
### Then we use it 

    ```
        create_r_signal("count", 0)
        
        puts count

        count(2)

        puts count

        puts count_previous

    ```

### Connecting Signals
    ```
        create_r_signal("count", 0)

        create_r_signal("steps") do |r|
            r.count + 2
        end

        puts steps

        count(3)

        puts steps
    ```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and the created tag, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/urchmaney/r_signals. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [code of conduct](https://github.com/urchmaney/r_signals/blob/main/CODE_OF_CONDUCT.md).

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the RSignals project's codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/urchmaney/r_signals/blob/main/CODE_OF_CONDUCT.md).
