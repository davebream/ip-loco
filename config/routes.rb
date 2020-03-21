# frozen_string_literal: true

Rails.application.routes.draw do
  constraints IpAddressMemberConstraint.new do
    defaults format: false do
      get '/*path', to: 'ip_addresses#show'
      delete '/*path', to: 'ip_addresses#destroy'
      put '/*path', to: 'ip_addresses#create'
    end
  end
end
