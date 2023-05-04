# frozen_string_literal: true

RSpec.describe 'GET /ips', type: :request do
  let(:ips) { app['persistence.rom'].relations[:ips] }

  before do
    ips.insert(enabled: false)
    ips.insert(enabled: false)
  end

  it 'returns a list of ips', :aggregate_failures do
    get '/ips'

    expect(last_response).to be_successful
    expect(last_response.content_type).to eq('application/json; charset=utf-8')

    response_body = JSON.parse(last_response.body)

    expect(response_body).to eq(
      [
        { 'id' => 1, 'enabled' => false },
        { 'id' => 2, 'enabled' => false }
      ]
    )
  end
end
