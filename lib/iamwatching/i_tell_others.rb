module Iamwatching
  module ITellOthers    
    
    def self.included(base)          
      base.send(:extend, ClassMethods)
      base.send(:include, InstanceMethods)
    end
    
    module InstanceMethods
      def it_happened(event, *args)
        self.curious_objects.each do |curious_object| 
          event_method = "#{event}_happened"
          if curiours_object.responds_to?(event_method) then
            curious_object.it_happened(event, args)
          else
            raise "Tried to trigger event #{event} but observer doesnt respond to #{event_method}"
          end
        end
      end
    end
    
    module ClassMethods
      
      def curious_objects
        @@curious_objects ||= Iamwatching::CuriousObjects.new
        @@curious_objects 
      end
      
      def tell(curious_object)        
        curious_objects
        @@curious_objects << curious_object
        curious_objects
      end      
    end
  end
end