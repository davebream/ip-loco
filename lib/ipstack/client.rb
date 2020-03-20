# frozen_string_literal: true

module Ipstack
  class Client
    include HTTParty

    base_uri 'api.ipstack.com'
    format :json

    ConntectionFailure = Class.new(StandardError)
    ConnectionTimeout  = Class.new(StandardError)
    ApiError           = Class.new(StandardError)

    def initialize(access_key = ENV['IPSTACK_ACCESS_KEY'])
      raise ArgumentError, 'access_key is mandatory' unless access_key.present?

      @options = { query: { access_key: access_key } }
    end

    def standard(ip_or_url)
      get("/#{ip_or_url}")
    end

    private

    def get(url)
      @response_body = self.class.get(url, @options).parsed_response

      return @response_body unless @response_body['success'] == false

      raise_api_error

    rescue SocketError
      raise ConntectionFailure, 'The ipstack api is not responding or no internet connection'
    rescue Net::OpenTimeout, Net::ReadTimeout
      raise ConnectionTimeout, 'The ipstack api request timed out'
    end

    def raise_api_error
      code = @response_body.dig('error', 'code')
      type = @response_body.dig('error', 'type')
      info = @response_body.dig('error', 'info')

      raise ApiError, "Ipstack: #{info} [code: #{code}, type: #{type}]"
    end
  end
end
