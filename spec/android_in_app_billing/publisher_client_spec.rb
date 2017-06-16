# frozen_string_literal: true
RSpec.describe AndroidInAppBilling::PublisherClient do
  let(:package_name) { 'com.spbtv.rspec' }
  before do
    AndroidInAppBilling.configure do |config|
      config.package_name = package_name
      config.json_key_path = 'spec/fixtures/json_key.json'
    end
  end

  around { |example| VCR.use_cassette(cassette) { example.call } }

  describe '#get_purchase_subscription' do
    let(:product_id) { 'spbtv_test' }
    let(:token) { 'kicgkmmieakfkgfnkclldoao.AO-J1OyAN-PCXHeriJ7W99KLeA_hZhqOZS3vnA9a5Mo1fyFhg4iF61FMVOfCqf8B9Jc5tzknR-Et58T79LsdIEWH2vBHOkSHJDOBTnknZgaSuhKjoGXq33M2VQxbQaz_KrQLRAZGPn7-gxQXcqaxvorNj4c2Q_1jaA' }

    subject(:get_purchase_subscription) { described_class.new.get_purchase_subscription(product_id, token) }

    context 'successfull request' do
      let(:cassette) { 'success' }

      it { is_expected.to be_a(AndroidInAppBilling::SubscriptionPurchase) }
    end

    context 'incorrect token' do
      let(:token) { 'wrong' }
      let(:cassette) { 'incorrect_token' }

      it { expect { get_purchase_subscription }.to raise_error(Google::Apis::ClientError) }
    end

    context 'incorrect product_id' do
      let(:product_id) { 'incorrect' }
      let(:cassette) { 'incorrect_product_id' }

      it { expect { get_purchase_subscription }.to raise_error(Google::Apis::ClientError) }
    end

    context 'incorrect package name' do
      let(:cassette) { 'incorrect_package_name' }
      let(:package_name) { 'com.spbtv.incorrect' }

      it { expect { get_purchase_subscription }.to raise_error(Google::Apis::ClientError) }
    end

    context 'server error' do
      let(:cassette) { 'server_error' }

      it { expect { get_purchase_subscription }.to raise_error(Google::Apis::ServerError) }
    end

    context 'authentication error' do
      let(:cassette) { 'auth_error' }

      it { expect { get_purchase_subscription }.to raise_error(Signet::AuthorizationError) }
    end
  end
end
