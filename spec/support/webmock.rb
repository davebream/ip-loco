require 'webmock/rspec'

RSpec.configure do |config|
  config.before(:each, block_requests: true) do
    WebMock.reset!
    WebMock.disable_net_connect!
  end
end
