# frozen_string_literal: true

RSpec.describe Watchdog::Services::PerformMonitoring, type: %i[request database] do
  subject(:service_call) { service_object.call }

  let(:service_object) { described_class.new }
  let(:requests) { app['persistence.rom'].relations[:requests] }

  before do
    WatchdogFactory[:ip]
    WatchdogFactory[:ip, enabled: false]
  end

  context 'for valid request' do
    before do
      allow(service_object).to receive(:perform_ping_request).and_return(123)
    end

    it 'creates 1 request record' do
      expect { service_call }.to change(requests, :count).by(1)
    end

    it 'request has valid response time' do
      service_call

      expect(requests.last.response_time).to eq 123
    end
  end

  context 'for long request' do
    before do
      allow(service_object).to receive(:perform_ping_request).and_raise(Timeout::Error)
    end

    it 'creates 1 request record' do
      expect { service_call }.to change(requests, :count).by(1)
    end

    it 'request has nil response time' do
      service_call

      expect(requests.last.response_time).to be_nil
    end
  end
end
