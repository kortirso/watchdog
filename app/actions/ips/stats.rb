# frozen_string_literal: true

module Watchdog
  module Actions
    module Ips
      class Stats < Watchdog::Action
        include Deps['persistence.rom', 'queries.ips.stats']

        params do
          required(:id).value(:integer)
        end

        def handle(request, response)
          ip = rom.relations[:ips].by_pk(request.params[:id]).one!

          response.format = :json
          response.body = ip.to_h.merge(stats: stats.call(ip_id: request.params[:id])).to_json
        end
      end
    end
  end
end
