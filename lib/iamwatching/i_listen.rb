module Iamwatching
  module IListen
    def self.included(base)          
      base.send(:extend, ClassMethods)
      base.send(:include, InstanceMethods)
    end
    
    module InstanceMethods
      def it_happened(event, *args)
        if observer.respond_to?(message)
          observer.send(message, *args)
        else
          Rails.logger.error "#{observer.inspect} doesn't respond to #{message} (params: #{args.inspect})"
        end
      end
    end
    
    module ClassMethods            
    end
  end
end