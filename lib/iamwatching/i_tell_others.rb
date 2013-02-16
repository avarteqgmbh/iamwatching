module Iamwatching
  module ITellOthers    
    
    def self.included(base)          
      base.send(:extend, ClassMethods)
      base.send(:include, InstanceMethods)
    end
    
    module InstanceMethods
    end
    
    module ClassMethods
      
      def it_happened(event, payload = nil)

        # Be aware of "self" here when mixing this module in to a class.
        # self = #<ToBeObserved:0x007ff0429cb6b8>
        # self.class = ToBeObserved
        
        #require 'debugger' ;; debugger
        self.curious_objects.each { |curious_object| curious_object.it_happend(event, payload) }
      end
      
      def curious_objects
        @@curious_objects ||= Iamwatching::CuriousObjects.new
        @@curious_objects 
      end
      
      # Add curious object
      def tell(curious_object)        
        curious_objects
        @@curious_objects.add(curious_object)
      end
    end
  end
end