# frozen_string_literal: true

class GetGeolocationData
  def initialize(client = Ipstack::Client.new)
    @client = client
  end

  def call(input)
    @client.standard(input)
  rescue Ipstack::Client::ConntectionFailure, Ipstack::Client::ConnectionTimeout, Ipstack::Client::ApiError => e
    raise Errors::ExternalAPIError, e.message
  end
end
