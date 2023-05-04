# frozen_string_literal: true

module Watchdog
  class Routes < Hanami::Routes
    root { 'Hello from Hanami' }
    get '/ips', to: 'ips.index'
  end
end
