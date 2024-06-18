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

  # Parameter Helpers
  # This class contains dynamic methods for signals
  # This is what we use in
  # create_r_signal("name") do |r|
  #
  # end
  #
  # r --> is this class
  class ParameterHelpers
    class << self
      attr_accessor :calling_node
    end
  end

  def self.included(base)
    base.extend ClassMethods
  end

  # Module class methods
  module ClassMethods
    def create_r_signal(name, val = nil, &block)
      node = RSNode.new val, self, &block
      register_signal(name, node)
      define_singleton_method(name) do |*args|
        return node.value if args.length <= 0

        node.value = args[0]
      end

      define_singleton_method("#{name}_previous") do
        node.previous
      end
    end

    def register_signal(signal_name, node)
      RSignals::ParameterHelpers.define_singleton_method(signal_name) do
        node.add_dependent_node(RSignals::ParameterHelpers.calling_node)
        node.value
      end
    end

    def full_signal_name(signal_name)
      "#{name}.#{signal_name}"
    end
  end
end
