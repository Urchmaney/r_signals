# frozen_string_literal: true

RSpec.describe RSignals::Signalizer do
  describe "instance methods" do
    before do
      stub_const "Klass", Class.new
      Klass.class_eval { include RSignals::Signalizer }
      Klass.class_eval { signalize sigma: 7, alpha: -> { sigma + 2 } }
    end
    it "should respond to signal instance method" do
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

  describe "class method" do
    before do
      stub_const "Klass", Class.new
      Klass.class_eval { include RSignals::Signalizer }
      Klass.class_eval { signalize :class, sigma: 7, alpha: -> { sigma + 2 } }
    end

    it "should respond to signal class method" do
      expect(Klass).to respond_to :sigma
    end

    it "should computed reactive class signal" do
      expect(Klass.alpha).to eq 9
      Klass.sigma 10
      expect(Klass.alpha).to eq 12
    end
  end
end
