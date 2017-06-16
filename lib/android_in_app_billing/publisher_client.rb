# frozen_string_literal: true
require_relative 'publisher_client/client_builder'

module AndroidInAppBilling
  # Client for android publisher v2 API
  #
  # @see https://developers.google.com/android-publisher/api-ref/
  #
  class PublisherClient
    def initialize
      @client = ClientBuilder.build
    end

    # @param product_id [String]
    # @param token [String]
    # @return [AndroidInAppBilling::SubscriptionPurchase]
    # @raise Google::Apis::ClientError
    # @raise Google::Apis::ServerError
    # @raise Signet::AuthorizationError
    def get_purchase_subscription(product_id, token)
      response = client.get_purchase_subscription(package_name, product_id, token)
      SubscriptionPurchase.new(response.to_h)
    end

    private

    attr_reader :client

    def package_name
      AndroidInAppBilling.config.package_name
    end
  end
end
