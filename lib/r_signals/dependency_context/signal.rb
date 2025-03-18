# frozen_string_literal: true

module RSignals
  module DependencyContext
    #
    # Signal Context
    #
    class Signal < Base
      def initialize(owner = nil, initial = nil)
        super(owner)
        @initial = initial
        return unless @initial

        @current = @initial
        @mark_dirty.call
        @last = @initial unless RSignals.reactive? @initial
      end

      def value # rubocop:disable Metrics/MethodLength
        if (RSignals.reactive? @current) && @event.raised?
          clear_dependencies
          start_collecting
          begin
            @last = @owner.instance_exec(&@current)
          rescue StandardError
            p $ERROR_INFO
          end
          finish_collecting
        end
        @event.reset
        collect
        @last
      end

      def value=(val)
        val = @initial if val == :default

        @current = val
        clear_dependencies
        @last = val unless RSignals.reactive? val

        @mark_dirty.call
      end

      def signal(val = nil)
        return value if val.nil?

        self.value = val
      end
    end
  end
end
