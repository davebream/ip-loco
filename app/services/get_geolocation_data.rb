# frozen_string_literal: true

class GetGeolocationData
  def initialize(client = Ipstack::Client.new)
    @client = client
  end

  def call(input)
    @ip_or_url = input

    verify_input!

    @client.standard(@ip_or_url)
  end

  private

  def verify_input!
    raise ArgumentError, 'Input has to be a valid IPv4, IPv6 address or url' unless input_valid_ip? || input_valid_url?
  end

  def input_valid_url?
    @ip_or_url =~ URI::regexp && !(URI.parse(@ip_or_url) rescue nil).nil? && @ip_or_url = URI.parse(@ip_or_url).host
  end

  def input_valid_ip?
    !(IPAddr.new(@ip_or_url) rescue nil).nil? && @ip_or_url = @ip_or_url
  end
end
