# frozen_string_literal: true

RSpec.describe 'GET /ips/:id/stats', type: %i[request database] do
  let!(:ip) { WatchdogFactory[:ip, enabled: false] }

  context 'for not existing ip' do
    it 'returns valid response', :aggregate_failures do
      get '/ips/0/stats'

      expect(last_response).to be_not_found
      expect(JSON.parse(last_response.body)['error']).to eq 'not_found'
    end
  end

  context 'for existing ip' do
    it 'returns valid response', :aggregate_failures do
      get "/ips/#{ip.id}/stats"

      expect(last_response).to be_ok
      expect(JSON.parse(last_response.body)).to eq(
        'id' => ip.id,
        'enabled' => false,
        'address' => '8.8.8.8',
        'stats' => {
          'completed_amount' => 0,
          'total_amount' => 0,
          'average_time' => 0,
          'min_response_time' => 0,
          'max_response_time' => 0,
          'median_time' => 0,
          'lost_requests_ratio' => 0
        }
      )
    end
  end
end
