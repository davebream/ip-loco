require 'rails_helper'

describe 'IpAddresses  API' do
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
end
