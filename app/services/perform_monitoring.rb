# frozen_string_literal: true

require 'parallel'
require 'resolv'

module Watchdog
  module Services
    class PerformMonitoring
      include Deps['persistence.rom']

      THREAD_POOL_SIZE = 5
      REQUEST_TIME_LIMIT_SECONDS = 1

      def call
        parallel_monitoring? ? perform_parallel_monitoring : perform_sequent_monitoring
      end

      private

      def parallel_monitoring?
        return false if Hanami.env?(:test)

        ENV.fetch('PARALLEL_MONITORING', false)
      end

      def relation
        rom.relations[:ips].where(enabled: true).select(:id, :address).to_a
      end

      def perform_parallel_monitoring
        Parallel.map(relation, in_threads: THREAD_POOL_SIZE) do |ip_struct|
          perform_address_check(ip_struct)
        end
      end

      def perform_sequent_monitoring
        relation.each do |ip_struct|
          perform_address_check(ip_struct)
        end
      end

      def perform_address_check(ip_struct)
        response_time = perform_ping_request(ip_struct.address)
        save_request_info(response_time, ip_struct.id)
      rescue Timeout::Error => _e
        save_request_info(nil, ip_struct.id)
      end

      def perform_ping_request(address)
        request = Resolv::IPv4::Regex.match?(address) ? 'ping' : 'ping6'
        Timeout.timeout(REQUEST_TIME_LIMIT_SECONDS) do
          `#{request} -c1 #{address}` =~ %r{= \d+\.\d+/(\d+\.\d+)}
          ::Regexp.last_match(1)&.to_f&.round(2)
        end
      end

      def save_request_info(response_time, ip_id)
        rom.relations[:requests].changeset(:create, response_time: response_time, ip_id: ip_id).commit
      end
    end
  end
end
