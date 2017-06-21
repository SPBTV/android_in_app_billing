# frozen_string_literal: true
RSpec.describe AndroidInAppBilling::SignatureVerifier do
  let(:raw_inapp_purchase) { build(:android_in_app_billing_raw_inapp_purchase) }
  let(:data) { raw_inapp_purchase[:data] }
  let(:signature) { Base64.decode64(raw_inapp_purchase[:signature]) }

  subject { described_class.new(data: data, signature: signature).call }

  before { AndroidInAppBilling.config.package_public_key = build(:android_in_app_billing_public_key) }

  context 'signature is valid' do
    it { is_expected.to be(true) }
  end

  context 'signature is invalid' do
    let(:signature) { Base64.encode64('wrong') }
    it { is_expected.to be(false) }
  end
end
