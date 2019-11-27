# frozen_string_literal: true
module AndroidInAppBilling
  class PublisherClient
    # Knows how to build android publisher v3 api client
    class ClientBuilder
      SCOPE = ['https://www.googleapis.com/auth/androidpublisher'].freeze

      class << self
        # @return [Google::Apis::AndroidpublisherV3::AndroidPublisherService]
        def build
          client_class.new.tap do |client|
            client.authorization = build_authorization
          end
        end

        private

        def client_class
          Google::Apis::AndroidpublisherV3::AndroidPublisherService
        end

        def build_authorization
          json_key_io = StringIO.new(File.read(json_key_path))
          Google::Auth::DefaultCredentials.make_creds(
            scope: SCOPE,
            json_key_io: json_key_io
          )
        end

        def json_key_path
          AndroidInAppBilling.config.json_key_path
        end
      end
    end
  end
end
