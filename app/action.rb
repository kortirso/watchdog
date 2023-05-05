# auto_register: false
# frozen_string_literal: true

require 'hanami/action'

module Watchdog
  class Action < Hanami::Action
    config.handle_exception ROM::TupleCountMismatchError => :handle_not_found

    private

    def handle_not_found(_request, response, _exception)
      response.format = :json
      response.status = 404
      response.body = { error: 'not_found' }.to_json
    end

    def handle_invalid_params(result, response)
      response.format = :json
      response.status = 422
      response.body = result.errors(full: true).to_h.values.flatten.map(&:capitalize).to_json
    end
  end
end
