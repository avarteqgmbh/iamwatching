require File.expand_path(File.dirname(__FILE__) + "/../spec_helper")

describe "Iamwatching" do
  
  it "should register a observer by one command a line" do
    class ToBeObserved
 
#      include Iamwatching::ITellOthers
      
      i_tell_others_about :done
      i_tell_others_about :nearly_done
      
      def its_done!
        it_happened(:done, {some: :payload})
      end
      
      def its_nearly_done!
        it_happened(:nearly_done)
      end
    end
    
    verbose_object = ToBeObserved.new
    
    class AnObserver
    end
    
    curious_object = AnObserver.new
    
    ToBeObserved.should respond_to(:i_tell_others_about)
    ToBeObserved.should respond_to(:tell)
    
    ToBeObserved.tell(curious_object).about(:done)
    ToBeObserved.curious_objects.should include(curious_object)
    
    verbose_object.should_receive(:it_happened).with(:done, {some: :payload})
    verbose_object.should_receive(:it_happened)
    verbose_object.its_done!
    verbose_object.its_nearly_done!    
  end
end