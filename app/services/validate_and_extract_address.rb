# frozen_string_literal: true

class ValidateAndExtractAddress
  AddressInvalid = Class.new(StandardError)

  ADDRESS_TYPES = { url: 'url', ip: 'ip' }.freeze

  def call(address)
    @address = address

    establish_address_type
    raise_invalid unless @address_type.present?
    result
  end

  private

  def establish_address_type
    @address_type = if valid_ip?
                      ADDRESS_TYPES[:ip]
                    elsif valid_url?
                      ADDRESS_TYPES[:url]
                    end
  end

  def valid_ip?
    IPAddr.new(@address)
  rescue StandardError
    false
  end

  def valid_url?
    matches_url_regexp? && url_parsable?
  end

  def matches_url_regexp?
    @address =~ URI::DEFAULT_PARSER.make_regexp
  end

  def url_parsable?
    address_url_host.present?
  rescue URI::InvalidURIError
    false
  end

  def result
    case @address_type
    when ADDRESS_TYPES[:ip]
      @address
    when ADDRESS_TYPES[:url]
      address_url_host
    end
  end

  def address_url_host
    URI.parse(@address).host
  end

  def raise_invalid
    raise AddressInvalid, "#{@address} is not a valid IPv4, IPv6 or url"
  end
end
