# frozen_string_literal: true

require 'rom-factory'

WatchdogFactory = ROM::Factory.configure do |config|
  config.rom = Watchdog::App.container['persistence.rom']
end

Dir["#{File.dirname(__FILE__)}/factories/*.rb"].each { |file| require file }
