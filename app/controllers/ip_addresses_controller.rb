# frozen_string_literal: true

class IpAddressesController < ApplicationController
  def show
    render json: ip_address.geolocation_data
  rescue ActiveRecord::RecordNotFound
    render json: { error: "No record found for #{params[:address]} address." }, status: :not_found
  rescue IpAddressValidator::AddressInvalid => e
    render json: { error: e.message }, status: :unprocessable_entity
  end

  def destroy
    ip_address.destroy

    render json: {}, status: :ok
  rescue ActiveRecord::RecordNotFound
    render json: { error: "No record found for #{params[:address]} address." }, status: :not_found
  rescue IpAddressValidator::AddressInvalid => e
    render json: { error: e.message }, status: :unprocessable_entity
  end

  def create
    CreateIpAddress.new.(address_param)

    render json: {}, status: :ok
  rescue IpAddressValidator::AddressInvalid => e
    render json: { error: e.message }, status: :unprocessable_entity
  rescue Ipstack::Client::ConntectionFailure, Ipstack::Client::ConnectionTimeout => e
    render json: { error: e.message }, status: :service_unavailable
  rescue StandardError => e
    render json: { error: e.message }, status: :internal_server_error
  end

  private

  def ip_address
    @ip_address ||= IpAddressesQuery.new.find_by_address!(address_param)
  end

  def address_param
    @address_param ||= IpAddressValidator.new.(params[:address])
  end
end
