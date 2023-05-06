# frozen_string_literal: true

WatchdogFactory.define(:request) do |f|
  f.response_time 100
  f.created_at { Time.now }
  f.association(:ip)
end
