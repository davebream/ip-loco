# frozen_string_literal: true

class IpAddressMemberConstraint
  PATH_REGEX = /\/ip_addresses\/(?<address>.+)/i.freeze

  def matches?(request)
    match = PATH_REGEX.match(request.env['REQUEST_URI'])
    return false unless match.present?

    request.path_parameters[:address] = match[:address]
    true
  end
end
