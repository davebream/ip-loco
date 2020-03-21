require 'rails_helper'

describe ValidateAndExtractAddress do
  describe '.call' do
    let(:result) { described_class.new.call(input) }

    context 'with valid ipv4 input' do
      let(:input) { '1.160.10.240' }

      it 'returns the input' do
        expect(result).to eq(input)
      end
    end

    context 'with valid ipv6 input' do
      let(:input) { '3ffe:1900:4545:3:200:f8ff:fe21:67cf' }

      it 'returns the input' do
        expect(result).to eq(input)
      end
    end

    context 'with valid  url input' do
      let(:input) { 'http://google.com/some-path?param=1' }

      it 'is extracts & returns url host' do
        expect(result).to eq('google.com')
      end
    end

    context 'with invalid url input' do
      let(:input) { 'http:/google.com/some-path?param=1' }

      it 'raises error' do
        expect { result }.to raise_error(ValidateAndExtractAddress::AddressInvalid, 'http:/google.com/some-path?param=1 is not a valid IPv4, IPv6 or url')
      end
    end

    context 'with invalid ipv4 input' do
      let(:input) { '1.160.10.240.' }

      it 'raises error' do
        expect { result }.to raise_error(ValidateAndExtractAddress::AddressInvalid, '1.160.10.240. is not a valid IPv4, IPv6 or url')
      end
    end

    context 'with invalid ipv6 input' do
      let(:input) { '3ffe:1900:4545:3:200:f8ff:fe21:67cf:' }

      it 'raises error' do
        expect { result }.to raise_error(ValidateAndExtractAddress::AddressInvalid, '3ffe:1900:4545:3:200:f8ff:fe21:67cf: is not a valid IPv4, IPv6 or url')
      end
    end
  end
end
