# frozen_string_literal: true
RSpec.describe AndroidInAppBilling::InappPurchase do
  describe '#initialize' do
    let :purchase_data do
      {
        "packageName" => "com.spbtv.android.rspec",
        "productId" => "test_subscription",
        "purchaseTime" => "1496880000000",
        "purchaseState" => 0,
        "developerPayload" => '{\"some\":\"data\"}',
        "purchaseToken" => "kicgkmmieakfkgfnkclldoao.AO-J1OyAN-PCXHeriJ7W99KLeA_hZhqOZS3vnA9a5Mo1fyFhg4iF61FMVOfCq8B9Jc5tzknR-Et58T79LsdIEWH2vBHOkSHJDOBTnknZgaSuhKjoGXq33M2VQxbQaz_KrQLRAZGPn7-gxQXcqaxvorNj4c2Q_1jaA",
        "autoRenewing" => true,
        "orderId" => "GPA.1234-5678-9012-34567"
      }
    end
    let(:signature) do
      'BpEAZWs0PE3ftjaII7IBQaVHKoSNky2Qp+CgGFzjsj99DUuEdgB29nM19ZRfzeNs0ifUgP70uLxyMQGx9sn0h53MeuSDx7zZ8VVrrSQ5+kDw/sO3+mimf1m5PNcXsIVQVn5bpiCngdO8GH3MNWFKE5XszC71kTserb5RHkkvDdk3uR9ar8740UgEQIpefwHSwaIRAwrV/NURWXt8YQ/zJcrJinAANbCOhQt2lzUFLlZYvRpgNPqgJK1P4EaHBa2n26ai2NH1uAlcewW4EZFPj5dEZJi/hI50geA+t301izXDknbWNRxftDN2VpAOxmWqDc3BksExpDflCkxtfn/RAg=='
    end

    subject { described_class.new(data: purchase_data.to_json, signature: signature) }

    it { expect(subject.package_name).to eq("com.spbtv.android.rspec") }
    it { expect(subject.product_id).to eq("test_subscription") }
    it { expect(subject.purchased_at).to eq(DateTime.strptime('1496880000.000', '%s')) }
    it { expect(subject.state).to eq('purchased') }
    it { expect(subject.developer_payload).to eq('{\"some\":\"data\"}') }
    it do
      expect(subject.token).to eq('kicgkmmieakfkgfnkclldoao.AO-J1OyAN-PCXHeriJ7W99KLeA_hZhqOZS3vnA9a5Mo1fyFhg4iF61FMVOfCq8B9Jc5tzknR-Et58T79LsdIEWH2vBHOkSHJDOBTnknZgaSuhKjoGXq33M2VQxbQaz_KrQLRAZGPn7-gxQXcqaxvorNj4c2Q_1jaA')
    end
    it { expect(subject.auto_renewing).to eq(true) }
    it { expect(subject.order_id).to eq('GPA.1234-5678-9012-34567') }
    it { expect(subject.raw).to eq(purchase_data.to_json) }
    it { expect(subject.signature).to eq(Base64.decode64(signature)) }

    context 'if purchase is cancelled' do
      before { purchase_data['purchaseState'] = 1 }
      it { expect(subject.state).to eq('cancelled') }
    end

    context 'if purchase is refunded' do
      before { purchase_data['purchaseState'] = 2 }
      it { expect(subject.state).to eq('refunded') }
    end
  end

  describe '#attributes' do
    subject { described_class.new(build(:android_in_app_billing_raw_inapp_purchase)).attributes }

    it 'contains only purchase data' do
      purchase_data_fields = [
        :package_name, :product_id, :purchased_at, :state,
        :developer_payload, :token, :auto_renewing, :order_id
      ]
      expect(subject.keys).to match_array(purchase_data_fields)
    end
  end

  describe '#signature_valid?' do
    let(:raw_inapp_purchase) { build(:android_in_app_billing_raw_inapp_purchase) }
    let(:data) { raw_inapp_purchase[:data] }
    let(:signature) { raw_inapp_purchase[:signature] }

    before { AndroidInAppBilling.config.package_public_key = build(:android_in_app_billing_public_key) }

    subject { described_class.new(data: data, signature: signature).signature_valid? }

    context 'signature is valid' do
      it { is_expected.to be(true) }
    end

    context 'signature is invalid' do
      let(:signature) { Base64.encode64('wrong') }
      it { is_expected.to be(false) }
    end
  end
end
