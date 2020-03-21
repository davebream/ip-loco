require 'rails_helper'

describe 'IpAddresses API' do
  let!(:ip_address) { IpAddress.create!(address: 'google.com', geolocation_data: { ip: '2607:f8b0:4005:808::200e' }) }

  after do
    ip_address.destroy
  end

  describe 'GET /ip_addresses/:address' do
    let(:request) { get "/ip_addresses/#{address}" }

    context 'with valid ip address param' do
      let(:address) { '2607:f8b0:4005:808::200e' }

      it 'renders geolocation data' do
        request
        json = JSON.parse(response.body)
        expect(json).to eq({ 'ip' => '2607:f8b0:4005:808::200e' })
      end

      it 'has 200 http status' do
        request
        expect(response).to have_http_status(200)
      end
    end

    context 'with valid url param' do
      let(:address) { 'http://google.com/test?some-query-param=2' }

      it 'renders geolocation data' do
        request
        json = JSON.parse(response.body)
        expect(json).to eq({ 'ip' => '2607:f8b0:4005:808::200e' })
      end

      it 'has 200 http status' do
        request
        expect(response).to have_http_status(200)
      end
    end

    context 'with invalid address param' do
      let(:address) { '2607:f8b0:4005:808::200e:' }

      it 'renders error' do
        request
        json = JSON.parse(response.body)
        expect(json).to eq({ 'error' => '2607:f8b0:4005:808::200e: is not a valid IPv4, IPv6 or url' })
      end

      it 'has 422 http status' do
        request
        expect(response).to have_http_status(422)
      end
    end

    context 'when ip address not found' do
      let(:address) { 'http://unknown-ip-address.com' }

      it 'renders error' do
        request
        json = JSON.parse(response.body)
        expect(json).to eq({ 'error' => 'No record found for http://unknown-ip-address.com address.' })
      end

      it 'has 404 http status' do
        request
        expect(response).to have_http_status(404)
      end
    end
  end

  describe 'DELETE /ip_addresses/:address' do
    let(:request) { delete "/ip_addresses/#{address}" }

    context 'with valid ip address param' do
      let(:address) { '2607:f8b0:4005:808::200e' }

      it 'destroys the record' do
        expect { request }.to change { IpAddress.count }.by(-1)
      end

      it 'has 200 http status' do
        request
        expect(response).to have_http_status(200)
      end
    end

    context 'with valid url param' do
      let(:address) { 'http://google.com/test?some-query-param=2' }

      it 'destroys the record' do
        expect { request }.to change { IpAddress.count }.by(-1)
      end

      it 'has 200 http status' do
        request
        expect(response).to have_http_status(200)
      end
    end

    context 'with invalid address param' do
      let(:address) { '2607:f8b0:4005:808::200e:' }

      it 'renders error' do
        request
        json = JSON.parse(response.body)
        expect(json).to eq({ 'error' => '2607:f8b0:4005:808::200e: is not a valid IPv4, IPv6 or url' })
      end

      it 'has 422 http status' do
        request
        expect(response).to have_http_status(422)
      end
    end

    context 'when ip address not found' do
      let(:address) { 'http://unknown-ip-address.com' }

      it 'renders error' do
        request
        json = JSON.parse(response.body)
        expect(json).to eq({ 'error' => 'No record found for http://unknown-ip-address.com address.' })
      end

      it 'has 404 http status' do
        request
        expect(response).to have_http_status(404)
      end
    end
  end

  describe 'PUT /ip_addresses/:address' do
    let(:request) { put "/ip_addresses/#{address}" }

    let(:ipstack_response) do
      {
        "ip" => "151.101.65.69",
        "type" => "ipv4",
        "continent_code" => "NA",
        "continent_name" => "North America",
        "country_code" => "US",
        "country_name" => "United States",
        "region_code" => "CA",
        "region_name" => "California",
        "city" => "San Francisco",
        "zip" => "94107",
        "latitude" => 37.76784896850586,
        "longitude" => -122.39286041259766,
        "location" => {
          "geoname_id" => 5391959,
          "capital" => "Washington D.C.",
          "languages" => [
            {
              "code" => "en",
              "name" => "English",
              "native" => "English"
            }
          ],
          "country_flag" => "http://assets.ipstack.com/flags/us.svg",
          "country_flag_emoji" => "🇺🇸",
          "country_flag_emoji_unicode" => "U+1F1FA U+1F1F8",
          "calling_code" => "1",
          "is_eu" => false
        }
      }
    end

    before { allow(ENV).to receive(:[]).with('IPSTACK_ACCESS_KEY').and_return('test-key') }

    context 'with valid url param' do
      let(:address) { 'http://stackoverflow.com/test?some-query-param=2' }

      before do
        stub_request(:get, 'http://api.ipstack.com/stackoverflow.com?access_key=test-key').to_return(status: 200, body: ipstack_response.to_json)
      end


      it 'creates new record' do
        request
        ip_address = IpAddress.last
        expect(ip_address.address).to eq('stackoverflow.com')
        expect(ip_address.geolocation_data).to eq(ipstack_response)
      end

      it 'has 200 http status' do
        request
        expect(response).to have_http_status(200)
      end
    end

    context 'when record for given address already exists' do
      let(:address) { 'http://google.com/test?some-query-param=2' }

      before do
        stub_request(:get, 'http://api.ipstack.com/google.com?access_key=test-key').to_return(status: 200, body: ipstack_response.to_json)
      end

      it 'does not create new record' do
        request
        expect { request }.not_to change { IpAddress.count }
      end

      it 'uses new fetched data to update the existing record' do
        request
        ip_address = IpAddress.find_by(address: 'google.com')
        expect(ip_address.geolocation_data).to eq(ipstack_response)
      end

      it 'has 200 http status' do
        request
        expect(response).to have_http_status(200)
      end
    end

    context 'with invalid address param' do
      let(:address) { '2607:f8b0:4005:808::200e:' }

      it 'renders error' do
        request
        json = JSON.parse(response.body)
        expect(json).to eq({ 'error' => '2607:f8b0:4005:808::200e: is not a valid IPv4, IPv6 or url' })
      end

      it 'has 422 http status' do
        request
        expect(response).to have_http_status(422)
      end
    end

    context 'when ipstack api connection fails' do
      let(:address) { 'http://stackoverflow.com' }

      before do
        stub_request(:get, 'http://api.ipstack.com/stackoverflow.com?access_key=test-key').to_raise(SocketError)
      end

      it 'renders error' do
        request
        expect(JSON.parse(response.body)).to eq({ 'error' => 'The ipstack api is not responding or no internet connection' })
      end

      it 'has 503 http status' do
        request
        expect(response).to have_http_status(503)
      end
    end

    context 'when ipstack api return error' do
      let(:address) { 'http://stackoverflow.com' }

      before do
        stub_request(:get, 'http://api.ipstack.com/stackoverflow.com?access_key=test-key').to_return(
          body: { success: false, error: { code: 101, info: 'Acces key invalid.', type: 'invalid_access_key' } }.to_json
        )
      end

      it 'renders error' do
        request
        expect(JSON.parse(response.body)).to eq({ 'error' => 'Ipstack: Acces key invalid. [code: 101, type: invalid_access_key]' })
      end

      it 'has 500 http status' do
        request
        expect(response).to have_http_status(500)
      end
    end
  end
end
