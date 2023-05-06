# frozen_string_literal: true

WatchdogFactory.define(:ip) do |f|
  f.address '8.8.8.8'
  f.enabled true
end
