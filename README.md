# Chartio Rails

As a Rails user you're probably familiar with the fact that Rails doesn't not create foreign keys in the database. Since ActiveRecord migrations don't cover this, it makes it very hard to work with Chartio because the metadata around how tables should be joined together only lives at the application layer. Using this gem, you will be able to output the metadata around the relationships in your Rails project and, working with your Chartio Customer Success Engineer, can get the relationships you need for your database.

## Installation

Add this line to your application's Gemfile:

```ruby
    group :development do
      gem 'chartio-rails'
    end
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install chartio-rails

## Usage

    $ rake chartio:schema

What's outputted is a csv with the needed schema information and a log file.  You should package both and email them over to Chartio.

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
