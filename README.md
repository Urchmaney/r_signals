# RSignals

RSignals is a reactive signal gem for ruby. Create reactivity with your variables.


## Installation

Install the gem and add to the application's Gemfile by executing:

```bash
    bundle add r_signals
```

## Usage

### First include the module

```ruby
    class Klass
        include RSignals::Signalizer

        signalize count: 0, shop: -> { count + 2 }
    end
```

### Then we use it 

```ruby
    instance = Klass.new
    
    puts instance.count     # 0

    instance.count 2    

    puts instance.count     # 2

    puts instance.shop     # 4

```

This instance methods are reactive and cached. from the above example, `shop` depends on `count` but will only call `count` if their is a change to `count`.


### Class based
```ruby
    class Klass
        include RSignals::Signalizer

        signalize :class, count: 0, shop: -> { count + 2 }
    end


    puts Klass.count     # 0

    Klass.count 2    

    puts Klass.count     # 2

    puts Klass.shop     # 4
```

## Development

N:B Files with name ending  with `_` should be ignored. they are currently not part of the repository. They are waiting to be deleted.

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and the created tag, and push the `.gem` file to [rubygems.org](https://rubygems.org).



## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/urchmaney/r_signals. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [code of conduct](https://github.com/urchmaney/r_signals/blob/main/CODE_OF_CONDUCT.md).

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the RSignals project's codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/urchmaney/r_signals/blob/main/CODE_OF_CONDUCT.md).
