# frozen_string_literal: true

module Watchdog
  module Persistence
    module Relations
      class Requests < ROM::Relation[:sql]
        schema(:requests, infer: true) do
          associations do
            belongs_to :ip
          end
        end

        auto_struct(true)
      end
    end
  end
end
