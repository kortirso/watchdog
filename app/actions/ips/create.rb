# frozen_string_literal: true

module Watchdog
  module Actions
    module Ips
      class Create < Watchdog::Action
        include Deps['persistence.rom']

        def handle(*, response)
          ip = rom.relations[:ips].changeset(:create).commit

          response.status = 201
          response.body = ip.to_json
        end
      end
    end
  end
end
