Rails.application.routes.draw do
  get '/*path', to: 'ip_addresses#show', constraints: IpAddressMemberConstraint.new, format: false
  delete '/*path', to: 'ip_addresses#destroy', constraints: IpAddressMemberConstraint.new, format: false
  put '/*path', to: 'ip_addresses#create', constraints: IpAddressMemberConstraint.new, format: false
end
