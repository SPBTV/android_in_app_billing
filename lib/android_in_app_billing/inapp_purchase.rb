# frozen_string_literal: true
module AndroidInAppBilling
  # Represents the INAPP_PURCHASE concept from Google Play In-app Billing v3 API
  # (java API for Android devices), including both data and signature
  #
  # @see https://developer.android.com/google/play/billing/billing_reference.html
  #
  class InappPurchase < SimpleDelegator
    include ParseTools

    Attributes = Struct.new(
      :raw, :signature, :order_id, :package_name, :product_id, :purchased_at,
      :state, :developer_payload, :token, :auto_renewing
    )

    PURCHASE_STATES = {
      0 => 'purchased',
      1 => 'cancelled',
      2 => 'refunded'
    }.freeze

    # @param data [String]
    # @param signature [String]
    # @!attribute raw
    #   @return [String]
    # @!attribute signature
    #   @return [String]
    # @!attribute order_id
    #   @return [String]
    # @!attribute package_name
    #   @return [String]
    # @!attribute product_id
    #   @return [String]
    # @!attribute purchased_at
    #   @return [DateTime]
    # @!attribute state
    #   @return [String]
    # @!attribute developer_payload
    #   @return [String]
    # @!attribute token
    #   @return [String]
    # @!attribute auto_renewing
    #   @return [Boolean]
    def initialize(data:, signature:)
      super Attributes.new(data, parse_signature(signature), *parse_data(data))
    end

    # @return [Hash]
    def attributes
      to_h.reject { |k, _| [:raw, :signature].include?(k) }
    end

    # @return [true, false]
    def signature_valid?
      signature_verifier.call
    end

    private

    def parse_signature(signature)
      Base64.decode64(signature)
    end

    def parse_data(raw_data) # rubocop:disable Metrics/MethodLength
      data = JSON.parse(raw_data)

      [
        data.fetch('orderId', ''),
        data.fetch('packageName'),
        data.fetch('productId'),
        millis_to_datetime(data.fetch('purchaseTime')),
        PURCHASE_STATES[data.fetch('purchaseState')],
        data.fetch('developerPayload', ''),
        data.fetch('purchaseToken'),
        data.fetch('autoRenewing')
      ]
    end

    def signature_verifier
      SignatureVerifier.new(data: raw, signature: signature)
    end
  end
end
