# frozen_string_literal: true
RSpec.describe AndroidInAppBilling::PublisherClient do
  let(:package_name) { 'com.spbtv.rspec' }
  let(:product_id) { 'spbtv_test' }
  let(:token) { 'kicgkmmieakfkgfnkclldoao.AO-J1OyAN-PCXHeriJ7W99KLeA_hZhqOZS3vnA9a5Mo1fyFhg4iF61FMVOfCqf8B9Jc5tzknR-Et58T79LsdIEWH2vBHOkSHJDOBTnknZgaSuhKjoGXq33M2VQxbQaz_KrQLRAZGPn7-gxQXcqaxvorNj4c2Q_1jaA' }
  let(:cassette) { "#{cassette_dir}/#{cassette_name}" }

  before do
    AndroidInAppBilling.configure do |config|
      config.package_name = package_name
      config.json_key_path = 'spec/fixtures/json_key.json'
    end
  end

  around { |example| VCR.use_cassette(cassette) { example.call } }

  shared_examples 'errors' do
    context 'when error occurs' do
      subject { -> { request } }

      context 'incorrect token' do
        let(:token) { 'wrong' }
        let(:cassette_name) { 'incorrect_token' }

        it { is_expected.to raise_error(Google::Apis::ClientError) }
      end

      context 'incorrect product_id' do
        let(:product_id) { 'incorrect' }
        let(:cassette_name) { 'incorrect_product_id' }

        it { is_expected.to raise_error(Google::Apis::ClientError) }
      end

      context 'incorrect package name' do
        let(:cassette_name) { 'incorrect_package_name' }
        let(:package_name) { 'com.spbtv.incorrect' }

        it { is_expected.to raise_error(Google::Apis::ClientError) }
      end

      context 'server error' do
        let(:cassette_name) { 'server_error' }

        it { is_expected.to raise_error(Google::Apis::ServerError) }
      end

      context 'authentication error' do
        let(:cassette) { 'auth_error' }

        it { is_expected.to raise_error(Signet::AuthorizationError) }
      end
    end
  end

  describe '#get_purchase_subscription' do
    subject(:request) { described_class.new.get_purchase_subscription(product_id, token) }

    let(:cassette_dir) { 'get_purchase_subscription' }

    context 'successfull request' do
      let(:cassette_name) { 'success' }

      it { is_expected.to be_a(AndroidInAppBilling::SubscriptionPurchase) }
    end

    include_examples 'errors'
  end

  describe '#revoke_purchase_subscription' do
    let(:cassette_dir) { 'revoke_purchase_subscription' }

    subject(:request) { described_class.new.revoke_purchase_subscription(product_id, token) }

    context 'successfull request' do
      let(:cassette_name) { 'success' }

      it { expect { request }.not_to raise_error }
    end

    include_examples 'errors'
  end
end
