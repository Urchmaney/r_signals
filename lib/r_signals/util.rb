# frozen_string_literal: true

#
# Module for uitility functions
#
module RSignals
  def self.reactive?(value)
    value.respond_to? :call
  end
end
