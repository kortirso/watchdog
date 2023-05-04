# frozen_string_literal: true

module Watchdog
  module Persistence
    module Relations
      class Ips < ROM::Relation[:sql]
        schema(:ips, infer: true)
      end
    end
  end
end
