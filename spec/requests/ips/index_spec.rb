# frozen_string_literal: true

RSpec.describe 'GET /ips', type: %i[request database] do
  let!(:ip_first) { WatchdogFactory[:ip] }
  let!(:ip_second) { WatchdogFactory[:ip, enabled: false] }

  it 'returns a list of ips', :aggregate_failures do
    get '/ips'

    expect(last_response).to be_successful
    expect(last_response.content_type).to eq('application/json; charset=utf-8')

    response_body = JSON.parse(last_response.body)

    expect(response_body).to eq(
      [
        { 'id' => ip_first.id, 'enabled' => true },
        { 'id' => ip_second.id, 'enabled' => false }
      ]
    )
  end
end
