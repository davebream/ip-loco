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
    @input =~ URI::DEFAULT_PARSER.make_regexp && !(begin
                                 URI.parse(@input)
                                                   rescue StandardError
                                                     nil
                               end).nil? && @result = URI.parse(@input).host
  end

  def input_valid_ip?
    (begin
        IPAddr.new(@input)
     rescue StandardError
       nil
      end).present? && @result = @input
  end
end
