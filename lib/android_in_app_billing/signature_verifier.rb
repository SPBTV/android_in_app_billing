# frozen_string_literal: true
module AndroidInAppBilling
  # Verifies that signature matches to the signed data
  #
  class SignatureVerifier
    # @param data [String]
    # @param signature [String]
    def initialize(data:, signature:)
      @data = data
      @signature = signature
    end

    # @return [true, false]
    def call
      public_key.verify(OpenSSL::Digest::SHA1.new, signature, data)
    end

    private

    attr_reader :data, :signature, :public_key

    def public_key
      OpenSSL::PKey::RSA.new(public_key_pem)
    end

    def public_key_pem
      AndroidInAppBilling.config.package_public_key
    end
  end
end
