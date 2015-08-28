# Rshop

Simple ecommerce solution for rails 4+


## Installation

1. Add this line to your application's Gemfile:

```ruby
gem 'rshop'
```

And then execute:
    $ bundle install

2. Generate migrations, models and admin panel
    $ rails g rshop

3. Run migrations
    $ rake db:migrate

4. Put into routes.rb
```ruby
Rshop::Router.routes(self)
```

## Usage

Check new routes and extend existing code to match your requirements
    $ rake routes

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/[USERNAME]/rshop.


## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

