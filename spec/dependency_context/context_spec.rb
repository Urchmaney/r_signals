# frozen_string_literal: true

RSpec.describe RSignals::DependencyContext do
  describe RSignals::DependencyContext::Base do
    it "should recognise collection stack" do
      context = RSignals::DependencyContext::Base.new
      context.start_collecting

      expect(RSignals::DependencyContext::Base.collection_stack.length).to eq(1)
    end
  end

  describe RSignals::DependencyContext::Signal do
    it "should set and get signals" do
      signal = RSignals::DependencyContext::Signal.new nil, 3
      expect(signal.signal).to eq(3)

      second_signal = RSignals::DependencyContext::Signal.new nil, -> { signal.signal + 3 }
      expect(second_signal.signal).to eq(6)
      signal.signal 4
      expect(second_signal.signal).to eq(7)
    end

    it "should change with computed" do
      signal = RSignals::DependencyContext::Signal.new nil, -> { 7 }
      expect(signal.signal).to eql(7)

      signal.signal(-> { 3 })
      expect(signal.signal).to eql(3)
    end

    it "should use cache value unless change in dependency" do
      signal = RSignals::DependencyContext::Signal.new self, 3
      expect(signal).to receive(:signal).and_call_original.exactly(3).times

      second_signal = RSignals::DependencyContext::Signal.new self, -> { signal.signal + 3 }
      second_signal.signal
      second_signal.signal
      second_signal.signal
      second_signal.signal
      expect(second_signal.signal).to eq(6)

      signal.signal 4

      second_signal.signal
      second_signal.signal
      second_signal.signal
      second_signal.signal
      expect(second_signal.signal).to eq(7)
    end
  end
end
