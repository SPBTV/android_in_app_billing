# frozen_string_literal: true
module AndroidInAppBilling
  # Represents SubscriptionPurchase resource from android publisher v3 API
  # @see https://developers.google.com/android-publisher/api-ref/purchases/subscriptions
  #
  class SubscriptionPurchase < SimpleDelegator
    include ParseTools

    Attributes = Struct.new(
      :kind, :auto_renewing, :country_code, :price_amount_micros,
      :price_currency_code, :payment_state, :expires_at, :started_at,
      :user_cancelled_at, :cancel_reason, :developer_payload
    )

    PAYMENT_STATES = {
      0 => 'pending',
      1 => 'received',
      2 => 'trial'
    }.freeze

    CANCEL_REASONS = {
      0 => 'user',
      1 => 'system'
    }.freeze

    # @param raw_subscription_purchase [Hash]
    # @!attribute kind
    #   @return [String]
    # @!attribute auto_renewing
    #   @return [true,false]
    # @!attribute country_code
    #   @return [String]
    # @!attribute price_amount_micros
    #   @return [Integer]
    # @!attribute price_currency_code
    #   @return [String]
    # @!attribute payment_state
    #   @return [String,nil]
    # @!attribute expires_at
    #   @return [DateTime]
    # @!attribute started_at
    #   @return [DateTime]
    # @!attribute user_cancelled_at
    #   @return [DateTime,nil]
    # @!attribute cancel_reason
    #   @return [String,nil]
    # @!attribute developer_payload
    #   @return [String,nil]
    def initialize(raw_subscription_purchase)
      super Attributes.new(*parse_raw(raw_subscription_purchase))
    end

    private

    def parse_raw(raw) # rubocop:disable Metrics/MethodLength,Metrics/AbcSize
      [
        raw.fetch(:kind),
        raw.fetch(:auto_renewing),
        raw.fetch(:country_code),
        raw.fetch(:price_amount_micros).to_i,
        raw.fetch(:price_currency_code),
        PAYMENT_STATES[raw.fetch(:payment_state, nil)],
        millis_to_datetime(raw.fetch(:expiry_time_millis)),
        millis_to_datetime(raw.fetch(:start_time_millis)),
        millis_to_datetime(raw.fetch(:user_cancellation_time_millis, nil)),
        CANCEL_REASONS[raw.fetch(:cancel_reason, nil)],
        raw.fetch(:developer_payload, nil)
      ]
    end
  end
end
