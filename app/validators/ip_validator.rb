# frozen_string_literal: true

require 'resolv'

module Watchdog
  module Validators
    class IpValidator < Watchdog::Validator
      schema do
        required(:address).filled(:string)
      end

      rule(:address) do
        unless values[:address] =~ Resolv::IPv4::Regex || values[:address] =~ Resolv::IPv6::Regex
          key.failure('has invalid format')
        end
      end
    end
  end
end
