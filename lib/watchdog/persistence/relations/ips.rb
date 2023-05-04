# frozen_string_literal: true

module Watchdog
  module Persistence
    module Relations
      class Ips < ROM::Relation[:sql]
        schema(:ips, infer: true)

        auto_struct(true)
      end
    end
  end
end
