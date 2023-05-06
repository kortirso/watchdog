# frozen_string_literal: true

RSpec.describe Watchdog::Queries::Ips::Stats, type: %i[request database] do
  subject(:query_call) { described_class.new.call(ip_id: ip.id) }

  let!(:ip) { WatchdogFactory[:ip] }

  context 'for empty requests' do
    it 'returns result with empty data' do
      expect(query_call).to eq(
        completed_amount: 0,
        total_amount: 0,
        average_time: 0,
        min_response_time: 0,
        max_response_time: 0,
        median_time: 0,
        lost_requests_ratio: 0
      )
    end
  end

  context 'when completed requests amount is odd' do
    before do
      WatchdogFactory[:request, ip: ip, response_time: 100]
      WatchdogFactory[:request, ip: ip, response_time: 50]
      WatchdogFactory[:request, ip: ip, response_time: 85]
      WatchdogFactory[:request, ip: ip, response_time: nil]
    end

    it 'returns result with data' do
      expect(query_call).to eq(
        completed_amount: 3,
        total_amount: 4,
        average_time: 78.33,
        min_response_time: 50,
        max_response_time: 100,
        median_time: 85,
        lost_requests_ratio: 25
      )
    end

    context 'when completed requests amount is even' do
      before do
        WatchdogFactory[:request, ip: ip, response_time: 90]
      end

      it 'returns result with data' do
        expect(query_call).to eq(
          completed_amount: 4,
          total_amount: 5,
          average_time: 81.25,
          min_response_time: 50,
          max_response_time: 100,
          median_time: 87.5,
          lost_requests_ratio: 20
        )
      end
    end
  end
end
