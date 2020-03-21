# frozen_string_literal: true

class IpAddressesQuery
  attr_reader :relation

  def initialize(relation = IpAddress.all)
    @relation = relation
  end

  def by_address(address)
    relation.where(address: address).or(relation.where("geolocation_data->>'ip' = ?", address))
  end

  def find_by_address!(address)
    by_address(address).first!
  end

  def find_or_new_by_address(address)
    by_address(address).first || relation.new(address: address)
  end
end
