module Iamwatching
  module ITellOthers    
    
    def self.included(base)          
      base.send(:extend, ClassMethods)
      base.send(:include, InstanceMethods)
    end
    
    module InstanceMethods
      def it_happened(event, *args)
        self.curious_objects
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