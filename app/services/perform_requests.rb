# frozen_string_literal: true

module Watchdog
  module Services
    class PerformRequests
      include Deps['persistence.rom']

      def call
        rom.relations[:ips].where(enabled: true).select(:id, :address).each do |ip_struct|
          perform_address_check(ip_struct)
        end
      end

      private

      def perform_address_check(ip_struct)
        response_time = perform_ping_request(ip_struct.address)
        rom.relations[:requests].changeset(:create, response_time: response_time, ip_id: ip_struct.id).commit
      rescue Timeout::Error => _e
        rom.relations[:requests].changeset(:create, completed: false, ip_id: ip_struct.id).commit
      end

      def perform_ping_request(address)
        Timeout.timeout(1) do
          `ping -c1 #{address}` =~ %r{= \d+\.\d+/(\d+\.\d+)}
          ::Regexp.last_match(1)&.to_f&.round(2)
        end
      end
    end
  end
end