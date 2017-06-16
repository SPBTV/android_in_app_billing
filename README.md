# AndroidInAppBilling

[![Build Status](https://secure.travis-ci.org/SPBTV/android_in_app_billing.png?branch=master)](http://travis-ci.org/SPBTV/android_in_app_billing)

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'android_in_app_billing'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install android_in_app_billing

## Usage

### Configuration
```ruby
AndroidInAppBilling.configure do |config|
  config.package_name = 'com.example.android'
  config.json_key_path = '/path/to/a/json_key.json'
  config.package_public_key = 'RSA public key'
end
```

### Working with purchase data from android clients

`purchase_data` and `data_signature` are the values android app gets from a purchase request. See https://developer.android.com/google/play/billing/billing_reference.html#getBuyIntent

```ruby
purchase = AndroidInAppBilling::InappPurchase.new(data: purchase_data, signature: data_signature)

# attribute accessors:
purchase.token # => JWT token
purchase.auto_renewing # => true/false
# ... (other attributes, see `AndroidInAppBilling::InappPurchase` and the link above)

# signature validation:
purchase.signature_valid? # => true/false
```

### Working with purchase updates

To get current subscription state this gem uses [android publisher v2 API](https://developers.google.com/android-publisher/api-ref/purchases/subscriptions)

```ruby
client = AndroidInAppBilling::PublisherClient.new
subscription = client.get_subscription_purchase(purchase.product_id, purchase.token)

# attribute accessors:
subscription.payment_state # => 'pending' / 'trial' / 'received'
subscription.expires_at # => some DateTime
# ... (other attributes, see `AndroidInAppBilling::SubscriptionPurchase` and the link above)
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/SPBTV/android_in_app_billing.


## License

The gem is available as open source under the terms of the [Apache 2.0 License](https://opensource.org/licenses/Apache-2.0).

