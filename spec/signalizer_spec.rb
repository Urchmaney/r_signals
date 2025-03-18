# frozen_string_literal: true

RSpec.describe RSignals::Signalizer do
  before do
    stub_const "Klass", Class.new
    Klass.class_eval { include RSignals::Signalizer }
    Klass.class_eval { signalize sigma: 7, alpha: -> { sigma + 2 } }
  end

  it "should respond to signal method" do
    instance = Klass.new
    expect(instance).to respond_to :sigma
  end

  it "should computed reactive signal" do
    instance = Klass.new
    expect(instance.alpha).to eq 9
    instance.sigma 10
    expect(instance.alpha).to eq 12
  end
end
