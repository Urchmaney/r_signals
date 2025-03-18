# frozen_string_literal: true

module RSignals
  # module to be included to allow signalizing
  module Signalizer
    def self.included(base)
      base.extend ClassMethods
    end

    def signal_instance(instance, key, value)
      instance_key = "@_signal_#{key}"
      node = instance.instance_variable_get(instance_key)
      return node if node

      instance.instance_variable_set(instance_key, RSignals::DependencyContext::Signal.new(self, value))
      instance.instance_variable_get(instance_key)
    end

    # module containing class methods that will be added to class that extends Signaler
    module ClassMethods
      def signalize(*args)
        throw "Wrong parameter strructure. follow  key: value form." unless args.length == 1 && args[0].is_a?(Hash)
        args[0].each do |key, val|
          define_method key do |value = nil|
            node = signal_instance(self, key, val)
            node.signal value
          end
        end
      end
    end
  end
end
