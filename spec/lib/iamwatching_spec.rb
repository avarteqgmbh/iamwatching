require File.expand_path(File.dirname(__FILE__) + "/../spec_helper")

describe "Iamwatching" do
  
  before(:each) do    
    
    class ToBeObserved
 
      i_tell_others_about :done
      i_tell_others_about :nearly_done
      
      def its_done!
        ToBeObserved.it_happened(:done)
      end
      
      def its_nearly_done!
        ToBeObserved.it_happened(:nearly_done, {some: :payload})
      end
    end
    
    class AnObserver
      
      let_me_know_about :done do |payload|
        :i_am_done
      end
      
      let_me_know_about :nearly_done do |payload|
        :i_am_nearly_done
      end
    end
    
    @verbose_object = ToBeObserved.new
    @curious_object = AnObserver.new
  end  
  
  after(:each) do
    # Undefine test classes
    Object.send(:remove_const, :ToBeObserved)
    Object.send(:remove_const, :AnObserver)
  end
  
  
  context "ToBeOberved" do
    it "should respond to class methods" do
      ToBeObserved.should respond_to(:i_tell_others_about)
      ToBeObserved.should respond_to(:tell)
    end
    
    it "should register an observer with an event" do
      ToBeObserved.tell(@curious_object).about(:done)
      ToBeObserved.curious_objects.find_by_object(@curious_object).should be_instance_of(Iamwatching::CuriousObject)
      
    end
    
    it "should respond to it_happened" do
      ToBeObserved.should respond_to(:it_happened)
    end
    
    it "should fire an event" do                
      ToBeObserved.should_receive(:it_happened).with(:done)
      @verbose_object.its_done!
    end
  
    it "should fire an event and pass a payload" do
      ToBeObserved.should_receive(:it_happened).with(:nearly_done, {some: :payload})
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
      ToBeObserved.tell(@curious_object).about(:done)
      ToBeObserved.curious_objects.find_by_object(@curious_object).should be_instance_of(Iamwatching::CuriousObject)
      @curious_object.should_not_receive(:nearly_done_happened)
      @curious_object.should_receive(:done_happened)
  
      @verbose_object.its_done!
    end
    
    it "should be notified when nearly_done" do
      ToBeObserved.tell(@curious_object).about(:nearly_done)
      ToBeObserved.curious_objects.find_by_object(@curious_object).should be_instance_of(Iamwatching::CuriousObject)
      ToBeObserved.curious_objects.find_by_object(@curious_object).events.should include(:nearly_done)
      @curious_object.should_not_receive(:done_happened)
      @curious_object.should_receive(:nearly_done_happened).with({some: :payload})
  
      @verbose_object.its_nearly_done!
    end
  end 
end