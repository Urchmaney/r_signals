# frozen_string_literal: true

RSpec.describe RSignals do
  before do
    stub_const "Klass", Class.new
    Klass.class_eval { include RSignals::RSignalable }
    Klass.class_eval { create_r_signal "sigma", 9 }
    Klass.instance_eval do
      def nine
        9
      end
    end
  end

  it "should create singleton function based on parameter" do
    expect(Klass).to respond_to :sigma
  end

  it "should return value when called" do
    expect(Klass.sigma).to eq 9
  end

  it "should set new value when called with argument" do
    Klass.sigma(3)
    expect(Klass.sigma).to eq 3
  end

  it "should return previous after set" do
    Klass.sigma(5)
    expect(Klass.sigma_previous).to eq 9
  end

  it "should allow multiple signals" do
    Klass.create_r_signal "moon", "white"
    expect(Klass.moon).to eq "white"
    expect(Klass.sigma).to eql 9
  end

  it "should raise error for type mismatch" do
    expect { Klass.sigma "cool" }.to raise_error RSignals::TypeMismatchError
  end

  it "should store lambda function" do
    Klass.create_r_signal("moon") { 1 + 2 }
    expect(Klass.moon).to eql 3
  end

  it "should access all signals in block" do
    Klass.create_r_signal "loom" do
      r.sigma
    end
  end

  it "should not throw error while referencing signal in parameter" do
    Klass.create_r_signal "loop" do |r|
      r.sigma + 1
    end
    expect { Klass.loop }.not_to raise_error
    expect(Klass.loop).to eq 10
  end

  it "should react if dependent signal changes" do
    Klass.create_r_signal "loop" do |r|
      r.sigma + 1
    end

    Klass.sigma(5)
    expect(Klass.loop).to eq 6

    Klass.sigma(99)
    expect(Klass.loop_previous).to eq nil
  end

  it "should access class methods" do
    Klass.create_r_signal "loop" do |r|
      r.sigma + nine
    end
    expect(Klass.loop).to eq 18
  end
end
