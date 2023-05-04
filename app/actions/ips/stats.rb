# frozen_string_literal: true

module Watchdog
  module Actions
    module Ips
      class Stats < Watchdog::Action
        include Deps['persistence.rom']

        params do
          required(:id).value(:integer)
        end

        def handle(request, response)
          ip = rom.relations[:ips].by_pk(request.params[:id]).one!

          response.format = :json
          response.body = ip.to_h.to_json
        end
      end
    end
  end
end
