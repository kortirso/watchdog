# frozen_string_literal: true

module Watchdog
  module Actions
    module Ips
      class Create < Watchdog::Action
        include Deps['persistence.rom', 'validators.ip_validator']

        params do
          required(:ip).hash
        end

        def handle(request, response)
          result = ip_validator.call(request.params[:ip])
          if result.success?
            ip = rom.relations[:ips].changeset(:create, request.params[:ip]).commit

            response.status = 201
            response.body = ip.to_json
          else
            handle_invalid_params(result, response)
          end
        end
      end
    end
  end
end
