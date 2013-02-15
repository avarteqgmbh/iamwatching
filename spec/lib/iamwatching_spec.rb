require File.expand_path(File.dirname(__FILE__) + "/../spec_helper")

describe "Iamwatching" do
  
  before(:all) do
  
    class ToBeObserved
 
      i_tell_others_about :done
      i_tell_others_about :nearly_done
      
      def its_done!
        it_happened(:done, {some: :payload})
      end
      
      def its_nearly_done!
        it_happened(:nearly_done)
      end
    end
            
    class AnObserver
      
      let_me_know_about :done do
        :i_am_done
      end
      
      let_me_know_about :nearly_done do |payload|
        [:i_am_nearly_done, payload]
      end
    end
    
    @verbose_object = ToBeObserved.new
    @curious_object = AnObserver.new
  end  
  
  context "ToBeOberved" do
    it "should respond to class methods" do
      ToBeObserved.should respond_to(:i_tell_others_about)
      ToBeObserved.should respond_to(:tell)
    end
    
    it "should register an observer with an event" do
      ToBeObserved.tell(@curious_object).about(:done)
      ToBeObserved.curious_objects.should include(@curious_object)      
    end
    
    it "should respond to it_happened" do
      @verbose_object.should respond_to(:it_happened)
    end
    
    it "should fire an event" do                
      @verbose_object.should_receive(:it_happened).with(:done)
      @verbose_object.its_done!
    end
  
    it "should fire an event and pass a payload" do
      @verbose_object.should_receive(:it_happened).with(:nearly_done, {some: :payload})
      @verbose_object.its_nearly_done!        
    end
  end
  
  context "AnObserver" do
    
    it "should respond to done_happened" do
      @curious_object.should respond_to(:done_happened)
    end    
    
    it "should respond to nearly_done_happened" do
      @curious_object.should respond_to(:nearly_done_happened)
    end
    
    it "should be notified when done" do
      @curious_object.should_receive(:nearly_done_happened).with({some: :payload})
    end
  end 
end