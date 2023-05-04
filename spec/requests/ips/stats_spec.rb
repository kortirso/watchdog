# frozen_string_literal: true

RSpec.describe 'GET /ips/:id/stats', type: %i[request database] do
  let(:ips) { app['persistence.rom'].relations[:ips] }

  let!(:ip_id) { ips.insert }

  context 'for not existing ip' do
    it 'returns valid response', :aggregate_failures do
      get '/ips/0/stats'

      expect(last_response).to be_not_found
      expect(JSON.parse(last_response.body)['error']).to eq 'not_found'
    end
  end

  context 'for existing ip' do
    it 'returns valid response', :aggregate_failures do
      get "/ips/#{ip_id}/stats"

      expect(last_response).to be_ok
      expect(JSON.parse(last_response.body)).to eq(
        'id' => ip_id, 'enabled' => false
      )
    end
  end
end
