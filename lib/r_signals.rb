# frozen_string_literal: true

require_relative "r_signals/version"
require_relative "r_signals/rs_node"

# Main Module
module RSignals
  # Type Mismatch exception class
  class TypeMismatchError < StandardError
    def initialize(value, type)
      super("TYPE MISMATCH: type of '#{value}' does not match default type : #{type}")
    end
  end

  def create_r_signal(name, val)
    node = RSNode.new(val)
    define_singleton_method(name) do |*args|
      return node.value if args.length <= 0

      node.value = args[0]
    end

    define_singleton_method("#{name}_previous") do
      node.previous
    end
  end
end
