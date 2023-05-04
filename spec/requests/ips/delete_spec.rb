# frozen_string_literal: true

RSpec.describe 'DELETE /ips/:id', type: %i[request database] do
  let(:ips) { app['persistence.rom'].relations[:ips] }

  let!(:ip_id) { ips.insert }

  context 'for not existing ip' do
    let(:request) { delete '/ips/0' }

    it 'does not delete Ip record in database' do
      expect { request }.not_to change(ips, :count)
    end

    it 'returns not found response', :aggregate_failures do
      request

      expect(last_response).to be_not_found
      expect(JSON.parse(last_response.body)['error']).to eq 'not_found'
    end
  end

  context 'for existing ip' do
    let(:request) { delete "/ips/#{ip_id}" }

    it 'deletes Ip record in database' do
      expect { request }.to change(ips, :count).by(-1)
    end

    it 'returns valid response', :aggregate_failures do
      request

      expect(last_response).to be_ok
      expect(JSON.parse(last_response.body)['message']).to eq "IP #{ip_id} is deleted"
    end
  end
end
