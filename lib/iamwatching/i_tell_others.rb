module Iamwatching
  module ITellOthers    
    
    def self.included(base)      
      puts base.class.name
      base.send(:class_variable_set, :@@curious_objects, Iamwatching::CuriousObjects.new)
    
      # base.class_eval { cattr_accessor :curious_objects }
    
      base.send(:extend, ClassMethods)
    end
    
    module ClassMethods
      def tell(curious_object)
        @@curious_objects
      end      
    end
  end
end