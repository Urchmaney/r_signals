# frozen_string_literal: true

RSpec.describe RSignals::Signalizer do
  before do
    stub_const "Klass", Class.new
    Klass.class_eval { include RSignals::Signalizer }
    Klass.class_eval { signalize sigma: 7, frer: 8 }
  end

  it "should respond to signal method" do
    instance = Klass.new
    expect(instance).to respond_to :sigma
  end
end
