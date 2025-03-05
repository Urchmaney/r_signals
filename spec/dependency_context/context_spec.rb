# frozen_string_literal: true

RSpec.describe RSignals::DependencyContext do
  describe RSignals::DependencyContext::Base do
    it "should recognise collection stack" do
      context = RSignals::DependencyContext::Base.new
      context.start_collecting

      expect(RSignals::DependencyContext::Base.collection_stack.length).to eq(1)
    end
  end
end
