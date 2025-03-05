# frozen_string_literal: true

require "set"

module RSignals
  module DependencyContext
    #
    # Base class for all dependency context to inherit from
    #
    class Base
      @collection_set = Set.new
      @collection_stack = []

      class << self
        attr_reader :collection_set, :collection_stack
      end

      attr_reader :mark_dirty

      def initialize(owner = nil)
        @owner = owner
        @dependencies = Set.new
        @event = EventDispatchers::FlagDispatcher.new
        @mark_dirty = -> { @event.raise }
      end

      # protected

      def invoke; end

      def start_collecting
        if Base.collection_set.include?(self)
          throw "A circular dependency has occured between signals.
          This can occur if signal reference each other in a loop."
        end

        Base.collection_set.add(self)
        Base.collection_stack.push(self)
      end

      def finish_collecting
        Base.collection_set.delete self
        throw "collectStart/collectEnd was called out of order." if Base.collection_stack.pop != self
      end

      def clear_dependencies
        @dependencies.each { |dep| dep.unsubscribe(@mark_dirty) }
        @dependencies.clear
      end

      def collect
        signal = Base.collection_stack[-1]
        return unless signal

        signal.dependencies.add(@event.Subscribable)
        @event.subscribe(signal.mark_dirty)
      end

      def dispose
        clear_dependencies
        @event.clear
      end
    end
  end
end
