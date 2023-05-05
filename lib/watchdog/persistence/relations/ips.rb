# frozen_string_literal: true

module Watchdog
  module Persistence
    module Relations
      class Ips < ROM::Relation[:sql]
        schema(:ips, infer: true) do
          associations do
            has_many :requests
          end
        end

        def with_requests
          combine(:requests)
        end

        auto_struct(true)
      end
    end
  end
end
