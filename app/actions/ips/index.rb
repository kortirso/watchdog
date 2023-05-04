# frozen_string_literal: true

module Watchdog
  module Actions
    module Ips
      class Index < Watchdog::Action
        include Deps['persistence.rom']

        def handle(*, response)
          ips =
            rom
            .relations[:ips]
            .select(:id, :enabled)
            .order(:id)
            .map(&:to_h)

          response.format = :json
          response.body = ips.to_json
        end
      end
    end
  end
end
