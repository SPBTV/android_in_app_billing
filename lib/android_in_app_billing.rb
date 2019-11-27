require 'json'
require 'openssl'
require 'base64'
require 'time'
require 'google/apis/androidpublisher_v3'
require 'dry-configurable'

# A toolkit to work with android in-app purchases
module AndroidInAppBilling
  extend Dry::Configurable

  ## SETTINGS
  # This two settings are for android publisher api client
  setting :package_name
  setting :json_key_path

  # This one is used to verify signature of an inapp purchase
  setting :package_public_key

  # Too small to have it's own file
  module ParseTools
    # @param millis [Integer]
    # @return [DateTime]
    # @raise ArgumentError
    def millis_to_datetime(millis)
      millis && DateTime.strptime((millis.to_f / 1000).to_s, '%s')
    end
  end
end

require_relative 'android_in_app_billing/inapp_purchase'
require_relative 'android_in_app_billing/publisher_client'
require_relative 'android_in_app_billing/signature_verifier'
require_relative 'android_in_app_billing/subscription_purchase'
require_relative 'android_in_app_billing/version'
