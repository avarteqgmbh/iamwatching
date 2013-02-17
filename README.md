# Iamwatching

Iamwatching is a class level implementation of the observer pattern.
In contrast to Ruby's [Observable](http://apidock.com/ruby/Observable) Iamwatching can be used
to track more than one event of an observable.

Example:
Consider you have a contract class that emits two events:

1. contract is due to be invoiced
2. contract has been canceled

So it's likely that there will be two different listeners being interested in either event no. 1 or event no. 2.

**Iamwatching helps to maintain a list of listeners for each event the class supports**.

## Installation

Add this line to your application's Gemfile:

    gem 'iamwatching'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install iamwatching

## Usage

TODO: Write usage instructions herea 

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
