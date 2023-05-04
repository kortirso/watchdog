# frozen_string_literal: true

RSpec.describe 'POST /ips', type: %i[request database] do
  let(:ips) { app['persistence.rom'].relations[:ips] }
  let(:request_headers) { { 'HTTP_ACCEPT' => 'application/json', 'CONTENT_TYPE' => 'application/json' } }

  context 'for valid params' do
    let(:request) { post '/ips', {}.to_json, request_headers }

    it 'creates Ip record in database' do
      expect { request }.to change(ips, :count).by(1)
    end

    it 'returns valid response' do
      request

      expect(last_response).to be_created
    end
  end
end
