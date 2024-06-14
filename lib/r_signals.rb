# frozen_string_literal: true

require_relative "r_signals/version"

# Main Module
module RSignals
  class Error < StandardError; end

  def create_r_signal(name, val)
    define_singleton_method(name) do
      val
    end
  end
end
