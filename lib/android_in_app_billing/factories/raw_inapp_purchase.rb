# frozen_string_literal: true
FactoryGirl.define do
  factory :android_in_app_billing_raw_inapp_purchase, class: Hash do
    package_name 'com.spbtv.android.rspec'
    product_id 'test_subscription'
    purchase_time { (Date.today - 1) }
    purchase_state 0
    developer_payload ''
    purchase_token 'kicgkmmieakfkgfnkclldoao.AO-J1OyAN-PCXHeriJ7W99KLeA_hZhqOZS3vnA9a5Mo1fyFhg4iF61FMVOfCq8B9Jc5tzknR-Et58T79LsdIEWH2vBHOkSHJDOBTnknZgaSuhKjoGXq33M2VQxbQaz_KrQLRAZGPn7-gxQXcqaxvorNj4c2Q_1jaA'
    auto_renewing true
    order_id 'GPA.1234-5678-9012-34567'

    trait :cancelled do
      purchase_state 1
      auto_renewing false
    end

    # After successfull in-app purchase, clients send us purchase data and
    # it's signature. Data is a json string. Signature is base64-encoded.
    #
    initialize_with do
      data = attributes

      # Google uses milliseconds since the epoch as timestamps
      data[:purchase_time] = data[:purchase_time].strftime('%s%3N')

      # Google uses lowerCamelCase for data field names
      to_lower_camelcase = Proc.new do |str|
        str.split('_').map.with_index { |part, i| i == 0 ? part : part.capitalize }.join
      end
      data = data.map { |k, v| [to_lower_camelcase.call(k.to_s), v] }.to_h

      data_json = data.to_json

      # Google uses SHA1 when signing data
      private_key = OpenSSL::PKey::RSA.new(build(:android_in_app_billing_private_key))
      signature = private_key.sign(OpenSSL::Digest::SHA1.new, data_json)
      # And then encodes signature using base64
      base64_encoded_signature = Base64.encode64(signature).delete("\n")

      { data: data_json, signature: base64_encoded_signature }
    end
  end
end
