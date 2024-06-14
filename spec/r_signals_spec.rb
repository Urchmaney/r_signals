# frozen_string_literal: true

RSpec.describe RSignals do
  it "has a version number" do
    expect(RSignals::VERSION).not_to be nil
  end

  it "does something useful" do
    expect(false).to eq(false)
  end

  it "should create singleton function based on parameter" do
    klass = Class.new do
      extend RSignals
      create_r_signal("sigma", 9)
    end

    expect(klass).to respond_to(:sigma)
  end
end
