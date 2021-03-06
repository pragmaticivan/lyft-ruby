[![Build Status](https://travis-ci.org/pragmaticivan/lyft-ruby.svg?branch=master)](https://travis-ci.org/pragmaticivan/lyft-ruby)
[![codecov.io](https://codecov.io/github/pragmaticivan/lyft-ruby/coverage.svg?branch=master)](https://codecov.io/github/pragmaticivan/lyft-ruby?branch=master)

# The Lyft Ruby Gem

> A Ruby interface to the Lyft API.

## Installation

Add this line to your application's Gemfile:

    gem 'lyft', require: 'lyft'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install lyft


## Configuration

```ruby
Lyft.configure do |config|
  config.client_id     = "YOUR_CLIENT_ID"
  config.client_secret = "YOUR_CLIENT_SECRET"
end
```

## Usage

TODO

## Contributors

* [Ivan Santos](https://github.com/pragmaticivan)

## Contributing

1. Fork it ( http://github.com/pragmaticivan/lyft-ruby/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request

## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).
