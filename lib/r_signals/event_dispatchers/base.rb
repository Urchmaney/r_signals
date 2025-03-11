# frozen_string_literal: true

module RSignals
  module EventDispatchers
    # The base abstract class for all event dispatching class
    class Base
      attr_reader :subscribable

      def initialize
        @subscribers = Set.new
        @subscribable = Subscribable.new self
      end

      def subscribe(handler)
        @subscribers.add(handler)
        -> { unsubscribe(handler) }
      end

      def unsubscribe(handler)
        @subscribers.delete handler
      end

      def clear
        @subscribers.clear
      end

      def notify_subscribers
        @subscribers.to_a.map(&:call)
      end
    end

    #
    # A safe way to subscribe and unsubscribe to events
    #
    class Subscribable
      def initialize(dispatcher)
        @dispatcher = dispatcher
      end

      def subscribe(handler)
        @dispatcher.subscribe(handler)
      end

      def unsubscribe(handler)
        @dispatcher.unsubscribe(handler)
      end
    end
  end
end
