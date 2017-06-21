# frozen_string_literal: true
FactoryGirl.define do
  # Both public and private keys were generated using this code:
  #
  # require 'openssl'
  #
  # key = OpenSSL::PKey::RSA.new(2048)
  #
  # key.public_key.to_pem # => public key
  # key.to_pem # => private key
  factory :android_in_app_billing_public_key, class: 'String' do
    public_key <<-KEY.gsub(/^\s*/, '')
      -----BEGIN PUBLIC KEY-----
      MIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEA0VZoxr2Z4Z55PR9DnBEl
      xNneoXvBEofqT0lstG/TKLaNdIGnyZASO0cupb1U08H/2qGIRFznSCJyW4H69Qsv
      FLQQCPy7mitA9HPK5FQ9/7//lwNBvZkxPaNGNbjpX2/nolQUjLJ8Mz088vfVBvf/
      WaabsjkIWtKIQgRWJU/Xa/Hbj8v5YcC500B4KiyMSKwKaOPylcQW3fX5w2f+JZbh
      krmqK+yQimvny07e/g6bS5BeJwmA9NG5PxGtM1ifgTK9ahypUkr6zb6Fy22POepO
      4PfXEIaE9rHrMkVE7A48SrSaB1yR0vubxp98oLLgFcpFYip+YFcuVqWGam13187a
      5wIDAQAB
      -----END PUBLIC KEY-----
    KEY

    initialize_with { attributes.values.join }
  end

  # Is used only for purchase data signing
  factory :android_in_app_billing_private_key, class: 'String' do
    private_key <<-KEY.gsub(/^\s*/, '')
      -----BEGIN RSA PRIVATE KEY-----
      MIIEowIBAAKCAQEA0VZoxr2Z4Z55PR9DnBElxNneoXvBEofqT0lstG/TKLaNdIGn
      yZASO0cupb1U08H/2qGIRFznSCJyW4H69QsvFLQQCPy7mitA9HPK5FQ9/7//lwNB
      vZkxPaNGNbjpX2/nolQUjLJ8Mz088vfVBvf/WaabsjkIWtKIQgRWJU/Xa/Hbj8v5
      YcC500B4KiyMSKwKaOPylcQW3fX5w2f+JZbhkrmqK+yQimvny07e/g6bS5BeJwmA
      9NG5PxGtM1ifgTK9ahypUkr6zb6Fy22POepO4PfXEIaE9rHrMkVE7A48SrSaB1yR
      0vubxp98oLLgFcpFYip+YFcuVqWGam13187a5wIDAQABAoIBAQC9/YaqmXoH4yR1
      7OIXyxhUSMheF0tr3h8yRpl6SeODl+taSjJWJYPmePxFQEi0x+XGL8TVBtyCA4F2
      u8lgjP319FZ5UaeSjJ8vPchu4mZCr6bxD+uigF7Ial9WcrScAZxhH55m87b1aibe
      /T9CS+JdI3E7l7eVdm5kPDtTMdt6Ayu/JIdPARdgOvh3Ez82I3ZO8HtgQ6bVD8J4
      x/UJSyqQkGuWi+pOaz3bWao/DlfilLhySov430xEWoH5FmOIgxqdVb3Lb0HlCFiQ
      2L9lsCyLZQplf1SQLbF+LDEg/l4cWVwWPBcCg5Gy/dXj3a3KQyowiZcnKPAGW+2o
      ZAcRjc9BAoGBAO2+1M/I918Os3IDQEuza+63N6YsgpKNdqBDokGuNpJz6pnefRFY
      6a5HKmCds/3YDhqijXNrMUWN9LRW7pQaxVZgnmo2hO/uYpgP+CaLX+FTc5gKB8RU
      Ujp4YvnBomSzGIBpUR8j/ioVKGfXKdagJFnTUHBUsLn5ktaYj8pjnyM9AoGBAOFp
      L+DTzQLkbLCLweianDp3NpD++CWOIucC4MZGI1BYBYROti55sCwyePcOeQXYIgxl
      hH8CiXa9lS4299lXUVPA4ATp7dtoNzNHfKN2qOzDQfl/K8NbQzVFjI/EDs+655KT
      68hbEZpdAY/WxrJzZ+yBlEwoOmlHkhEjxZPhqIjzAoGAEH3GQUuNbTiV1fjHwviF
      Kh/nak14GTZa3i8S2D9/ZZVI1reKMWPbgc1J8T2/OIJ+J/bSnQj4d/yq1r+Y+QkK
      Wz2Ef5WcjxAYIrgo3HOaiQTC5e78LvAya//hzbVS0G1j67Rifih+/uhMzzcrncmp
      +9keoUwenifjuaMHhmB2r3kCgYAP69MS6ULgwmue6LAwksMYKhVzll7GoEx8zqo7
      tvaFlUIGf1zE2ZmE9aevo5kOvZ5iC8WZBv/YoDlqQz2sX0uCQ+xOzIsdZTYI7DK0
      hQwXdQ8y5TWdHdQYbiooeWumZog2xTXxN+V9ZrZWh5APSLF9dgWYf3rotsJtbX5m
      HJk/2wKBgG8NCzqi/INQNdDBsSDPdi1oU2nvI/eQfGcnvyvuDHmd3nd/GrPkHUHn
      suAxetCm2u/Q0B+V+5szG3UyF/AIiKoYdBf2fwnAxEyRebQFCisGxzb6izxM/z6V
      8NweZnhm8CMgaka6W+IjKu2OB3CeqIPDzKo+GY5ArdEcsgjtuo9n
      -----END RSA PRIVATE KEY-----
    KEY

    initialize_with { attributes.values.join }
  end
end
