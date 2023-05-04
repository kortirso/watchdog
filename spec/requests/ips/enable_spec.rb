# frozen_string_literal: true

RSpec.describe 'POST /ips/:id/enable', type: %i[request database] do
  let(:ips) { app['persistence.rom'].relations[:ips] }
  let(:request_headers) { { 'HTTP_ACCEPT' => 'application/json', 'CONTENT_TYPE' => 'application/json' } }

  let!(:ip_id) { ips.insert }

  context 'for not existing ip' do
    before { post '/ips/0/enable', {}.to_json, request_headers }

    it 'does not update record in database' do
      expect(ips.by_pk(ip_id).one.enabled).to be_falsy
    end

    it 'returns not found response', :aggregate_failures do
      expect(last_response).to be_not_found
      expect(JSON.parse(last_response.body)['error']).to eq 'not_found'
    end
  end

  context 'for existing ip' do
    before { post "/ips/#{ip_id}/enable", {}.to_json, request_headers }

    it 'updates record in database' do
      expect(ips.by_pk(ip_id).one.enabled).to be_truthy
    end

    it 'returns valid response', :aggregate_failures do
      expect(last_response).to be_ok
      expect(JSON.parse(last_response.body)['message']).to eq "IP #{ip_id} is enabled"
    end
  end
end
