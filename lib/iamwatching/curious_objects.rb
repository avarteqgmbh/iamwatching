module Iamwatching
  class CuriousObjects < Hash
    def initialize
      @list = []
    end
  
    def add(obj)
      curious = CuriousObject.new(obj)
      @list << curious
      curious
    end
  
    def find_by_object(obj)
      @list.detect { |curious| curious.obj == obj }
    end
  
    def find_by_event(event)
      @list.select { |curious| curious.events.include?(event) }
    end
  end
end