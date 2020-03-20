# frozen_string_literal: true

class IpAddressValidator
  AddressInvalid = Class.new(StandardError)

  def call(input)
    @input = input

    raise AddressInvalid, "#{input} is not a valid IPv4, IPv6 or url" unless input_valid?

    @result
  end

  private

  def input_valid?
    input_valid_ip? || input_valid_url?
  end

  def input_valid_url?
    @input =~ URI::regexp && !(URI.parse(@input) rescue nil).nil? && @result = URI.parse(@input).host
  end

  def input_valid_ip?
    !(IPAddr.new(@input) rescue nil).nil? && @result = @input
  end
end
