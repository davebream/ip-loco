# frozen_string_literal: true

class ValidateAndExtractAddress
  AddressInvalid = Class.new(StandardError)

  def call(input)
    @input = input

    establish_input_type
    raise_invalid unless @input_type.present?
    result
  end

  private

  def establish_input_type
    @input_type = if input_valid_ip?
                    :ip
                  elsif input_valid_url?
                    :url
                  end
  end

  def input_valid_ip?
    IPAddr.new(@input)
  rescue StandardError
    false
  end

  def input_valid_url?
    input_matches_url_regexp? && input_url_parsable?
  end

  def input_matches_url_regexp?
    @input =~ URI::DEFAULT_PARSER.make_regexp
  end

  def input_url_parsable?
    input_url_host.present?
  rescue URI::InvalidURIError
    false
  end

  def result
    case @input_type
    when :ip
      @input
    when :url
      input_url_host
    end
  end

  def input_url_host
    URI.parse(@input).host
  end

  def raise_invalid
    raise AddressInvalid, "#{@input} is not a valid IPv4, IPv6 or url"
  end
end
