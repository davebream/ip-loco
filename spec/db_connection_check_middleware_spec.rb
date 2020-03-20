require 'rails_helper'

describe DBConnectionCheckMiddleware do
  describe '.call' do
    let(:env) { 'env' }
    let(:app) { double(call: env) }

    let(:result) { described_class.new(app).call(env) }

    context 'when db connected' do
      it 'calls the app with env' do
        expect(app).to receive(:call).with(env)
        result
      end
    end

    context 'when not connected' do
      before do
        allow(ActiveRecord::Base).to receive_message_chain(:connection_pool, :with_connection).and_raise(StandardError)
      end

      it 'returns error json response' do
        expect(result).to eq([503, {"Content-Type"=>"application/json"}, ["{\"error\":\"Could not connect to the DB\"}"]])
      end
    end
  end
end
