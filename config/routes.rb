Rails.application.routes.draw do
  get '/*path', to: 'ip_addresses#show', constraints: IpAddressMemberConstraint.new, format: false
end
