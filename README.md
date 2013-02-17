# Iamwatching

## What is it?

Iamwatching is a class level implementation of the observer pattern.
In contrast to Ruby's [Observable](http://apidock.com/ruby/Observable) Iamwatching can be used
to track more than one event of an observable.

## Motivation

- Loosly coupling
- Convention about message exchange - Broadcast
- Observable doesn't need to know **what** listeners will do with an event message and how the respond to it.
- Observable class stays small and clean.

### Example

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

    class ToBeObserved
    
      i_tell_others_about :done
      i_tell_others_about :nearly_done
      
      def its_done!
        ToBeObserved.it_happened(:done)
      end
      
      def its_nearly_done!
        ToBeObserved.it_happened(:nearly_done, {some: :payload})
      end
    end
    
    class AnObserver
      
      let_me_know_about :done do |payload|
        # Do something
      end
      
      let_me_know_about :nearly_done do |payload|
        # Do something
      end
    end
    
    verbose_object = ToBeObserved.new
    curious_object = AnObserver.new
    
    ToBeObserved.tell(curious_object).about(:nearly_done)
    @verbose_object.its_nearly_done!

The methods let_me_know_about will create instance methods such as done_happened that will
be invoked in case the verbose_oject will fire the event "done".

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
