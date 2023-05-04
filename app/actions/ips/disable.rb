# frozen_string_literal: true

module Watchdog
  module Actions
    module Ips
      class Disable < Watchdog::Action
        include Deps['persistence.rom']

        params do
          required(:id).value(:integer)
        end

        def handle(request, response)
          relation = rom.relations[:ips].by_pk(request.params[:id])
          relation.one!

          relation.command(:update).call(enabled: false)

          response.format = :json
          response.body = { message: "IP #{request.params[:id]} is disabled" }.to_json
        end
      end
    end
  end
end
