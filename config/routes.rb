# frozen_string_literal: true

module Watchdog
  class Routes < Hanami::Routes
    root { 'Hello from Hanami' }

    get '/ips', to: 'ips.index'
    post '/ips', to: 'ips.create'
    post '/ips/:id/enable', to: 'ips.enable'
    post '/ips/:id/disable', to: 'ips.disable'
    get '/ips/:id/stats', to: 'ips.stats'
    delete '/ips/:id', to: 'ips.delete'
  end
end
