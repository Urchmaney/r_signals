# frozen_string_literal: true

require_relative "./event_dispatchers/base"

module RSignals
  # EventDispatchers
  module EventDispatchers
    autoload :FlagDispatcher, "r_signals/event_dispatchers/flag_dispatcher"
  end
end
