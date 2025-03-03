# frozen_string_literal: true

RSpec.describe RSignals::EventDispatchers do
  describe RSignals::EventDispatchers::FlagDispatcher do
  before(:each) { @count = 0 }
  let(:handler) do
    ->(_) { @count += 1 }
  end
  let(:flag_dispatcher) { RSignals::EventDispatchers::FlagDispatcher.new }
    
    it "should fire handler when subscribed" do
      flag_dispatcher.subscribe(handler)
      flag_dispatcher.raise
      expect(@count).to eq(1)
    end

    it "should only fire handler again after reset" do
      flag_dispatcher.subscribe(handler)
      flag_dispatcher.raise
      flag_dispatcher.raise
      flag_dispatcher.reset
      flag_dispatcher.raise
      expect(@count).to eq(2)
    end

    it "should not fire handler after cleared" do
      flag_dispatcher.subscribe(handler)
      flag_dispatcher.raise
      expect(@count).to eq(1)

      flag_dispatcher.clear
      flag_dispatcher.raise
      expect(@count).to eq(1)
    end
  end
end
