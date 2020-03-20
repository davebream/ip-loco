# frozen_string_literal: true

class IpAddress < ApplicationRecord
  scope :by_address, ->(address){ where(address: address).or(where("geolocation_data->>'ip' = ?", address)) }
end
