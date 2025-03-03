# frozen_string_literal: true

module RSignals
  module EventDispatchers
    # Flag dispatcher that has a boolean value
    class FlagDispatcher < Base
      def initialize
        super
        @value = false
      end

      def raise
        return if @value

        @value = true
        notify_subscribers
      end

      def raised?
        @value
      end

      def subscribe(handler)
        unsub = super
        handler.call if @value
        unsub
      end

      def reset
        @value = false
      end
    end
  end
end
