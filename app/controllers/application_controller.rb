# frozen_string_literal: true

class ApplicationController < ActionController::API
  rescue_from ActiveRecord::RecordNotFound, with: :render_not_found_response
  rescue_from Errors::ExternalAPIError, with: :render_bad_gateway_response

  private

  def render_not_found_response(_exception)
    render json: { error: 'Could not find record' }, status: :not_found
  end

  def render_bad_gateway_response(_exception)
    render json: { error: 'External API error' }, status: :bad_gateway
  end
end
