# frozen_string_literal: true

RSpec.describe 'POST /ips', type: %i[request database] do
  let(:ips) { app['persistence.rom'].relations[:ips] }
  let(:request_headers) { { 'HTTP_ACCEPT' => 'application/json', 'CONTENT_TYPE' => 'application/json' } }

  context 'for valid params' do
    let(:request) { post '/ips', { ip: { address: '192.168.0.1' } }.to_json, request_headers }

    it 'creates Ip record in database' do
      expect { request }.to change(ips, :count).by(1)
    end

    it 'returns valid response' do
      request

      expect(last_response).to be_created
    end
  end

  context 'for invalid params' do
    let(:request) { post '/ips', { ip: { address: '192.168.0.600' } }.to_json, request_headers }

    it 'does not creates Ip record in database' do
      expect { request }.not_to change(ips, :count)
    end

    it 'returns unprocessable response', :aggregate_failures do
      request

      expect(last_response).to be_unprocessable
      expect(JSON.parse(last_response.body)).to eq(['Address has invalid format'])
    end
  end

  context 'for empty params' do
    let(:request) { post '/ips', {}.to_json, request_headers }

    it 'does not creates Ip record in database' do
      expect { request }.not_to change(ips, :count)
    end

    it 'returns unprocessable response' do
      request

      expect(last_response).to be_unprocessable
    end
  end
end
