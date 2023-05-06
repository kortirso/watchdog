# frozen_string_literal: true

require 'sidekiq-scheduler'

module Watchdog
  module Workers
    class PerformMonitoring
      include Sidekiq::Job
      include Deps['services.perform_monitoring']

      def perform
        perform_monitoring.call
      end
    end
  end
end
