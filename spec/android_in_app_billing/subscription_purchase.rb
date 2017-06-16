# frozen_string_literal: true
RSpec.describe AndroidInAppBilling::SubscriptionPurchase do
  describe '#initialize' do
    let(:purchase_data) do
      {
        kind: "androidpublisher#subscriptionPurchase",
        start_time_millis: "1495804701620",
        expiry_time_millis: "1495874499494",
        auto_renewing: true,
        price_currency_code: "RUB",
        price_amount_micros: "15000000",
        payment_state: 1,
        country_code: "US",
        developer_payload: '{\"some\":\"data\"}',
      }
    end

    subject { described_class.new(purchase_data) }

    it { expect(subject.kind).to eq('androidpublisher#subscriptionPurchase') }
    it { expect(subject.auto_renewing).to eq(true) }
    it { expect(subject.country_code).to eq('US') }
    it { expect(subject.price_amount_micros).to eq(15000000) }
    it { expect(subject.price_currency_code).to eq('RUB') }
    it { expect(subject.payment_state).to eq('received') }
    it { expect(subject.started_at).to eq(DateTime.strptime('1495804701.620', '%s')) }
    it { expect(subject.expires_at).to eq(DateTime.strptime('1495874499.494', '%s')) }
    it { expect(subject.developer_payload).to eq('{\"some\":\"data\"}') }

    context 'subscription payment is pending' do
      before { purchase_data.merge!(payment_state: 0) }

      it { expect(subject.payment_state).to eq('pending') }
    end

    context 'subscription is in trial' do
      before { purchase_data.merge!(payment_state: 2) }

      it { expect(subject.payment_state).to eq('trial') }
    end

    context 'subscription is cancelled by user' do
      before do
        purchase_data.merge!(
          cancel_reason: 0,
          user_cancellation_time_millis: "1495820000000"
        )
      end

      it { expect(subject.cancel_reason).to eq('user') }
      it { expect(subject.user_cancelled_at).to eq(DateTime.strptime('1495820000.000', '%s')) }
    end

    context 'subscription is cancelled by system' do
      before { purchase_data.merge!(cancel_reason: 1) }

      it { expect(subject.cancel_reason).to eq('system') }
    end
  end
end
