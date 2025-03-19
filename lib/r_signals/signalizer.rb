# frozen_string_literal: true

module RSignals
  # module to be included to allow signalizing
  module Signalizer
    def self.included(base)
      base.extend ClassMethods
      base.extend self
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
        to, hash = verify_args(*args)
        if to == :class
          define_signal_singleton_methods hash
        else
          define_signal_methods hash
        end
      end

      private

      def verify_args(*args)
        unless (args.length == 1 && args[0].is_a?(Hash)) || (
          args.length == 2 && args[0].is_a?(Symbol) && args[1].is_a?(Hash))
          throw "Wrong parameter structure."
        end
        args.length == 2 ? args : [:instance, *args]
      end

      def define_signal_methods(hash)
        hash.each do |key, val|
          define_method key do |value = nil|
            node = signal_instance(self, key, val)
            node.signal value
          end
        end
      end

      def define_signal_singleton_methods(hash)
        hash.each do |key, val|
          define_singleton_method key do |value = nil|
            node = signal_instance(self, key, val)
            node.signal value
          end
        end
      end
    end
  end
end
