module Iamwatching
  # Manages the list of events a curious object
  # wants to be notified about
  class CuriousObject
  
    attr_accessor :obj, :events
  
    def initialize(obj)
      @obj  = obj
      @events = []
    end
  
    def about(event)
      @events << event unless @events.include?(event)
    end
  
    def it_happend(event, payload = nil)    
      raise "I am of the class #{@obj.class.name} and I don't resond to #{event} as expected." unless @events.include?(event)
    
      puts "Fired #{event} for #{obj}"
      event_method = "#{event}_happened"
      if @obj.responds_to?(event_method) then
        @obj.send(event_method, payload)
      else
        raise "Tried to trigger event #{event} but the observer #{@obj.class.name} doesnt respond to #{event_method}"
      end    
    end  
  end
end