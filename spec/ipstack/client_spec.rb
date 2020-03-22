require 'rails_helper'

describe Ipstack::Client, block_requests: true do
  describe '.standard' do
    let(:access_key) { '1234567' }
    let(:ip_or_url) { 'google.com' }
    let(:request_url) { "#{Ipstack::Client.base_uri}/#{ip_or_url}?access_key=#{access_key}" }

    let(:result) { described_class.new(access_key).standard(ip_or_url) }

    context 'when request is successfull' do
      it 'responds with parsed json body' do
        VCR.use_cassette('successful_result') do
          expect(result).to eq({
            "ip" =>  "2607:f8b0:4005:808::200e",
            "type" =>  "ipv6",
            "continent_code" =>  "NA",
            "continent_name" =>  "North America",
            "country_code" =>  "US",
            "country_name" =>  "United States",
            "region_code" =>  "CA",
            "region_name" =>  "California",
            "city" =>  "Mountain View",
            "zip" =>  "94043",
            "latitude" =>  37.38801956176758,
            "longitude" =>  -122.07431030273438,
            "location" =>  {
              "geoname_id" =>  5375480,
              "capital" =>  "Washington D.C.",
              "languages" =>  [
                {
                  "code" =>  "en",
                  "name" =>  "English",
                  "native" =>  "English"
                }
              ],
              "country_flag" =>  "http://assets.ipstack.com/flags/us.svg",
              "country_flag_emoji" =>  "🇺🇸",
              "country_flag_emoji_unicode" =>  "U+1F1FA U+1F1F8",
              "calling_code" =>  "1",
              "is_eu" =>  false
            }
          })
        end
      end
    end

    context 'when access key is nil' do
      let(:access_key) { nil }

      it 'raises error' do
        expect { result }.to raise_error(ArgumentError, 'access_key is mandatory')
      end
    end

    context 'when api response has error' do
      let(:access_key) { 'some-invalid-key' }

      it 'raises error' do
        VCR.use_cassette('unsuccessful_result') do
          expect { result }.to raise_error(Ipstack::Client::ApiError, 'Ipstack: You have not supplied a valid API Access Key. [Technical Support: support@apilayer.com] [code: 101, type: invalid_access_key]')
        end
      end
    end

    context 'when api connection failed' do
      before do
        stub_request(:get, request_url).to_raise(SocketError)
      end

      it 'raises error' do
        expect { result }.to raise_error(Ipstack::Client::ConntectionFailure, 'The ipstack API is not responding or no internet connection')
      end
    end

    context 'when api connection open timeout' do
      before do
        stub_request(:get, request_url).to_raise(Net::OpenTimeout)
      end

      it 'raises error' do
        expect { result }.to raise_error(Ipstack::Client::ConnectionTimeout, 'The ipstack API request timed out')
      end
    end

    context 'when api connection read timeout' do
      before do
        stub_request(:get, request_url).to_raise(Net::ReadTimeout)
      end

      it 'raises error' do
        expect { result }.to raise_error(Ipstack::Client::ConnectionTimeout, 'The ipstack API request timed out')
      end
    end
  end
end
