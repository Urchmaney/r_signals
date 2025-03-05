# frozen_string_literal: true

require_relative "r_signals/version"
require_relative "r_signals/event_dispatchers"
require_relative "r_signals/dependency_context"
require_relative "r_signals/r_node"
require_relative "r_signals/r_signalable"

# Parent Container Module
module RSignals
  # Type Mismatch exception class
  class TypeMismatchError < StandardError
    def initialize(value, type)
      super("TYPE MISMATCH: type of '#{value}' does not match default type : #{type}")
    end
  end
end
