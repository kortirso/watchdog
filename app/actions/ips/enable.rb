# frozen_string_literal: true

module Watchdog
  module Actions
    module Ips
      class Enable < Watchdog::Action
        include Deps['persistence.rom']

        params do
          required(:id).value(:integer)
        end

        def handle(request, response)
          relation = rom.relations[:ips].by_pk(request.params[:id])
          relation.one!

          relation.changeset(:update, enabled: true).commit

          response.format = :json
          response.body = { message: "IP #{request.params[:id]} is enabled" }.to_json
        end
      end
    end
  end
end
