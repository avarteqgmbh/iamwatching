class Object
  class << self
    def i_tell_others_about(*args)
      self.send(:include, Iamwatching::ITellOthers)
    end
  end
end