# frozen_string_literal: true

require "set"

module RSignals
  # Class definition to create node
  class RNode
    attr_reader :previous, :value_type, :dependent_nodes, :binding

    def initialize(val, binding, &block)
      @value = val
      @previous = nil
      @value_type = val.class
      @block = block
      @dependent_nodes = Set.new
      @clean = !val.nil?
      @binding = binding
      # run_block if block
    end

    def value
      return @value if @block.nil? || clean?

      run_block
    end

    def value=(new_val)
      raise TypeMismatchError.new new_val, value_type if new_val.class != value_type

      store_new_value new_val
      mark_dependents_dirty
    end

    def r
      RSignals::ParameterHelpers.calling_node = self
      RSignals::ParameterHelpers
    end

    def add_dependent_node(node)
      @dependent_nodes.add(node)
    end

    def clean?
      @clean
    end

    def mark_dirty
      @clean = false
      mark_dependents_dirty
    end

    def mark_dependents_dirty
      @dependent_nodes.each(&:mark_dirty)
    end

    def run_block
      result = binding.instance_exec r, &@block
      store_new_value result
    end

    def store_new_value(new_val)
      @previous = @value
      @value = new_val
    end
  end
end
