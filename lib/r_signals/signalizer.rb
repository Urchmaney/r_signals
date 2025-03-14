# frozen_string_literal: true

module RSignals
  # module to be included to allow signalizing
  module Signalizer
    def self.included(base)
      base.extend ClassMethods
    end

    # module containing class methods that will be added to class that extends Signaler
    module ClassMethods
      def signalize(*args)
        throw "Wrong parameter strructure. follow  key: value form." unless args.length == 1 && args[0].is_a?(Hash)
        args[0].each do |key, val|
          node = RSignals::DependencyContext::Signal.new self, val
          define_method key do |value = nil|
            node.signal value
          end
        end
      end
    end
  end
end
