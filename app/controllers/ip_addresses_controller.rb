# frozen_string_literal: true

class IpAddressesController < ApplicationController
  rescue_from IpAddressValidator::AddressInvalid, with: :render_address_invalid_response

  def show
    render json: ip_address.geolocation_data
  end

  def destroy
    ip_address.destroy

    render json: {}, status: :ok
  end

  def create
    CreateIpAddress.new.call(address_param)

    render json: {}, status: :ok
  end

  private

  def render_address_invalid_response(exception)
    render json: { error: exception.message }, status: :unprocessable_entity
  end

  def ip_address
    @ip_address ||= IpAddressesQuery.new.find_by_address!(address_param)
  end

  def address_param
    @address_param ||= IpAddressValidator.new.call(params[:address])
  end
end
