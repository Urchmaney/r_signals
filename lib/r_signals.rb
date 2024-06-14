# frozen_string_literal: true

require_relative "r_signals/version"

module RSignals
  class Error < StandardError; end
  
  def create_r_signal(name, val)
    define_singleton_method(name) do
      return val
    end
  end
end
