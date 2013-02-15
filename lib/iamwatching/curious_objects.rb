module Iamwatching
  class CuriousObjects < Array
    alias_method :about, :push
  end
end