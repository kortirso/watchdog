# frozen_string_literal: true

RSpec.describe 'GET /ips', type: %i[request database] do
  let(:ips) { app['persistence.rom'].relations[:ips] }

  let!(:ip_first) { ips.insert(enabled: false) }
  let!(:ip_second) { ips.insert(enabled: false) }

  it 'returns a list of ips', :aggregate_failures do
    get '/ips'

    expect(last_response).to be_successful
    expect(last_response.content_type).to eq('application/json; charset=utf-8')

    response_body = JSON.parse(last_response.body)

    expect(response_body).to eq(
      [
        { 'id' => ip_first, 'enabled' => false },
        { 'id' => ip_second, 'enabled' => false }
      ]
    )
  end
end
