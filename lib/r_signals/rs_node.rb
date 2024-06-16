# frozen_string_literal: true

module RSignals
  # Class definition to create node
  class RSNode
    attr_reader :value, :previous, :value_type

    def initialize(val)
      @value = val
      @previous = nil
      @value_type = val.class
    end

    def value=(new_val)
      raise TypeMismatchError.new new_val, value_type if new_val.class != value_type

      @previous = @value
      @value = new_val
    end
  end
end
