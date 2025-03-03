# frozen_string_literal: true

module RSignals
  # The base abstract class for all event dispatching class
  class EventDispatcherBase
    def initialize
      @subscribers = Set.new
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

    def notify_subscribers(value)
      @subscribers.to_a.map { |handler| handler.call(value) }
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
