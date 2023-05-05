# frozen_string_literal: true

module Watchdog
  module Actions
    module Ips
      class Stats < Watchdog::Action
        include Deps['persistence.rom', 'queries.ips.stats']

        params do
          required(:id).value(:integer)
          optional(:time_from).value(:string)
          optional(:time_to).value(:string)
        end

        def handle(request, response)
          ip = rom.relations[:ips].by_pk(request.params[:id]).one!

          response.format = :json
          response.body = ip.to_h.merge(stats: find_stats(request)).to_json
        end

        private

        def find_stats(request)
          stats.call(
            ip_id: request.params[:id],
            time_from: request.params[:time_from],
            time_to: request.params[:time_to]
          )
        end
      end
    end
  end
end
