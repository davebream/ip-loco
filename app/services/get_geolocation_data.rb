# frozen_string_literal: true

class GetGeolocationData
  def initialize(client = Ipstack::Client.new)
    @client = client
  end

  def call(input)
    @client.standard(input)
  rescue *client_errors => e
    raise Errors::ExternalAPIError, e.message
  end

  private

  def client_errors
    [
      Ipstack::Client::ConntectionFailure,
      Ipstack::Client::ConnectionTimeout,
      Ipstack::Client::ApiError
    ]
  end
end
