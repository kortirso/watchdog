# frozen_string_literal: true

require 'rack/test'

# rubocop: disable RSpec/ContextWording
RSpec.shared_context 'Hanami app' do
  let(:app) { Hanami.app }
end
# rubocop: enable RSpec/ContextWording

RSpec.configure do |config|
  config.include Rack::Test::Methods, type: :request
  config.include_context 'Hanami app', type: :request
end
