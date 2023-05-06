# frozen_string_literal: true

require 'parallel'

module Watchdog
  module Services
    class PerformRequests
      include Deps['persistence.rom']

      THREAD_POOL_SIZE = 5
      REQUEST_TIME_LIMIT_SECONDS = 1

      def call
        Parallel.map(
          rom.relations[:ips].where(enabled: true).select(:id, :address).to_a,
          in_threads: THREAD_POOL_SIZE
        ) do |ip_struct|
          perform_address_check(ip_struct)
        end
      end

      private

      def perform_address_check(ip_struct)
        response_time = perform_ping_request(ip_struct.address)
        save_request_info(response_time, ip_struct.id)
      rescue Timeout::Error => _e
        save_request_info(nil, ip_struct.id)
      end

      def perform_ping_request(address)
        Timeout.timeout(REQUEST_TIME_LIMIT_SECONDS) do
          `ping -c1 #{address}` =~ %r{= \d+\.\d+/(\d+\.\d+)}
          ::Regexp.last_match(1)&.to_f&.round(2)
        end
      end

      def save_request_info(response_time, ip_id)
        rom.relations[:requests].changeset(:create, response_time: response_time, ip_id: ip_id).commit
      end
    end
  end
end
