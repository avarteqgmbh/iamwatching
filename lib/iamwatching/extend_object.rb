class Object
  class << self
    def i_tell_others_about(*args)
      self.send(:include, Iamwatching::ITellOthers)
    end
    
    def let_me_know_about(event, &block)
      if block_given? then
        define_method "#{event}_happened", block
      end
    end
  end
end