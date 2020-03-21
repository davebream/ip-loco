# frozen_string_literal: true

class CreateIpAddress
  def call(address)
    ip_address                  = IpAddressesQuery.new.find_or_new_by_address(address)
    ip_address.geolocation_data = GetGeolocationData.new.call(address)
    ip_address.save!
  end
end
