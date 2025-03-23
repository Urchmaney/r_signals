# frozen_string_literal: true

# This file is currently not used in the repository. Just waiting to be deleted

module RSignals
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

  # Included module to that bring signal behaviour
  module RSignalable
    def self.included(base)
      base.extend ClassMethods
    end

    # Module class methods
    module ClassMethods
      def create_r_signal(name, val = nil, &block)
        node = RNode.new val, self, &block
        register_signal name, node
        create_r_node_method name, node
        create_r_node_previous_method name, node
      end

      def create_r_node_method(name, node)
        define_singleton_method(name) do |*args|
          return node.value if args.length <= 0

          node.value = args[0]
        end
      end

      def create_r_node_previous_method(name, node)
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
end
