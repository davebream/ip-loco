# frozen_string_literal: true

class IpAddressesController < ApplicationController
  def show
    render json: ip_address.geolocation_data
  rescue ActiveRecord::RecordNotFound
    render json: { error: "No record found for #{params[:address]} address." }, status: :not_found
  rescue IpAddressValidator::AddressInvalid => e
    render json: { error: e.message }, status: :unprocessable_entity
  end

  private

  def ip_address
    @ip_address ||= IpAddress.by_address(address_param).first!
  end

  def address_param
    @address_param ||= IpAddressValidator.new.(params[:address])
  end
end
