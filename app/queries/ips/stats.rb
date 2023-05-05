# frozen_string_literal: true

module Watchdog
  module Queries
    module Ips
      class Stats
        include Deps['persistence.db']

        def call(ip_id:, time_from: nil, time_to: nil)
          @select_condition = fetch_select_condition(ip_id, time_from, time_to)

          basis_stats = db.fetch(
            "SELECT
              COUNT(id) as total_amount,
              COUNT(response_time) as completed_amount,
              AVG(response_time) AS average_time,
              MIN(response_time) AS min_response_time,
              MAX(response_time) AS max_response_time
            FROM requests
            WHERE #{@select_condition}"
          ).first

          basis_stats.merge(
            median_time: find_median(basis_stats[:completed_amount]),
            lost_requests_ratio: find_lost_requests_ratio(basis_stats)
          ).transform_values { |e| e&.round(2).to_f }
        end

        private

        def fetch_select_condition(ip_id, time_from, time_to)
          result = ["ip_id = #{ip_id}"]
          result << "DATE(created_at) >= '#{time_from}'" if time_from
          result << "DATE(created_at) <= '#{time_to}'" if time_to

          result.join(' AND ')
        end

        def find_median(completed_amount)
          return if completed_amount.zero?

          if completed_amount.odd?
            median_request(completed_amount / 2, 1).first
          else
            median_request((completed_amount / 2) - 1, 2).all.sum { |e| e[:response_time] } / 2
          end
        end

        def median_request(offset, limit)
          db.fetch(
            "SELECT response_time
            FROM requests
            WHERE #{@select_condition} AND response_time IS NOT NULL
            ORDER BY response_time ASC
            OFFSET ?
            LIMIT ?",
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
