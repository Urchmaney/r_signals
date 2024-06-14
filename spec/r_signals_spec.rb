# frozen_string_literal: true

RSpec.describe RSignals do
  before do
    stub_const "Klass", Class.new
    Klass.class_eval { extend RSignals }
    Klass.class_eval { create_r_signal "sigma", 9 }
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
end
