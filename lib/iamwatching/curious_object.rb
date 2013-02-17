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
      event_method = "#{event}_happened"
      return unless @events.include?(event)
            
      if @obj.respond_to?(event_method) then
        @obj.send(event_method, payload)
      else
        raise "Tried to trigger event #{event} but the observer #{@obj.class.name} doesnt respond to #{event_method}"
      end    
    end  
  end
end