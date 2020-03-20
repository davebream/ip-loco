# frozen_string_literal: true

class GetGeolocationData
  def initialize(client = Ipstack::Client.new)
    @client = client
  end

  def call(input)
    @client.standard(input)
  end
end
