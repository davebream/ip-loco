require 'rails_helper'

describe GetGeolocationData do
  let(:client) { instance_double('Ipstack::Client', standard: true) }

  describe '.call' do
    let(:result) { described_class.new(client).call(input) }

    context 'with ipv4 input' do
      let(:input) { '1.160.10.240' }

      it 'is uses client to retrieve geolocation data' do
        expect(client).to receive(:standard).with(input).and_return(true)
        result
      end
    end

    context 'with ipv6 input' do
      let(:input) { '3ffe:1900:4545:3:200:f8ff:fe21:67cf' }

      it 'is uses client to retrieve geolocation data' do
        expect(client).to receive(:standard).with(input).and_return(true)
        result
      end
    end

    context 'with url input' do
      let(:input) { 'http://google.com/some-path?param=1' }

      it 'is extracts url host &  uses client to retrieve geolocation data' do
        expect(client).to receive(:standard).with('google.com').and_return(true)
        result
      end
    end

    context 'with invalid url input' do
      let(:input) { 'http:/google.com/some-path?param=1' }

      it 'raises argument error' do
        expect { result }.to raise_error(ArgumentError, 'Input has to be a valid IPv4, IPv6 address or url')
      end
    end

    context 'with invalid ipv4 input' do
      let(:input) { '1.160.10.240.' }

      it 'raises argument error' do
        expect { result }.to raise_error(ArgumentError, 'Input has to be a valid IPv4, IPv6 address or url')
      end
    end

    context 'with invalid ipv6 input' do
      let(:input) { '3ffe:1900:4545:3:200:f8ff:fe21:67cf:' }

      it 'raises argument error' do
        expect { result }.to raise_error(ArgumentError, 'Input has to be a valid IPv4, IPv6 address or url')
      end
    end
  end
end
