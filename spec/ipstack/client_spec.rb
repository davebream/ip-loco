require 'rails_helper'

describe Ipstack::Client do
  describe '.standard' do
    let(:access_key) { '1234567' }
    let(:ip_or_url) { 'google.com' }
    let(:request_url) { "#{Ipstack::Client.base_uri}/#{ip_or_url}?access_key=#{access_key}" }

    let(:result) { described_class.new(access_key).standard(ip_or_url) }

    context 'when request is successfull' do
      before do
        stub_request(:get, request_url).to_return(body: { ip: 'google.com' }.to_json)
      end

      it 'responds with parsed json body' do
        expect(result).to eq({ 'ip' => 'google.com' })
      end
    end

    context 'when access key is nil' do
      let(:access_key) { nil }

      it 'raises error' do
        expect { result }.to raise_error(ArgumentError, 'access_key is mandatory')
      end
    end

    context 'when api request unsuccessful' do
      before do
        stub_request(:get, request_url).to_return(
          body: { success: false, error: { code: 101, info: 'Acces key invalid.', type: 'invalid_access_key' } }.to_json
        )
      end

      it 'raises error' do
        expect { result }.to raise_error(Ipstack::Client::ApiError, 'Ipstack: Acces key invalid. [code: 101, type: invalid_access_key]')
      end
    end

    context 'when api connection failed' do
      before do
        stub_request(:get, request_url).to_raise(SocketError)
      end

      it 'raises error' do
        expect { result }.to raise_error(Ipstack::Client::ConntectionFailure, 'The ipstack api is not responding or no internet connection')
      end
    end

    context 'when api connection open timeout' do
      before do
        stub_request(:get, request_url).to_raise(Net::OpenTimeout)
      end

      it 'raises error' do
        expect { result }.to raise_error(Ipstack::Client::ConnectionTimeout, 'The ipstack api request timed out')
      end
    end

    context 'when api connection read timeout' do
      before do
        stub_request(:get, request_url).to_raise(Net::ReadTimeout)
      end

      it 'raises error' do
        expect { result }.to raise_error(Ipstack::Client::ConnectionTimeout, 'The ipstack api request timed out')
      end
    end
  end
end
