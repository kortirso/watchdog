# frozen_string_literal: true

module Watchdog
  module Queries
    module Ips
      class Stats
        include Deps['persistence.db']

        def call(ip_id:)
          basis_stats = db.fetch(
            'SELECT
              COUNT(id) as total_amount,
              COUNT(response_time) as completed_amount,
              AVG(response_time) AS average_time,
              MIN(response_time) AS min_response_time,
              MAX(response_time) AS max_response_time
            FROM requests
            WHERE ip_id = ?',
            ip_id
          ).first

          basis_stats.merge(
            median_time: find_median(basis_stats[:completed_amount], ip_id),
            lost_requests_ratio: find_lost_requests_ratio(basis_stats)
          ).transform_values { |e| e&.round(2) }
        end

        private

        def find_median(completed_amount, ip_id)
          return if completed_amount.zero?

          if completed_amount.odd?
            median_request(ip_id, completed_amount / 2, 1).first
          else
            median_request(ip_id, (completed_amount / 2) - 1, 2).all.sum { |e| e[:response_time] } / 2
          end
        end

        def median_request(ip_id, offset, limit)
          db.fetch(
            'SELECT response_time
            FROM requests
            WHERE ip_id = ? AND response_time IS NOT NULL
            ORDER BY response_time ASC
            OFFSET ?
            LIMIT ?',
            ip_id,
            offset,
            limit
          )
        end

        def find_lost_requests_ratio(stats)
          return if stats[:total_amount].zero?

          100 - (100.0 * stats[:completed_amount] / stats[:total_amount])
        end
      end
    end
  end
end
