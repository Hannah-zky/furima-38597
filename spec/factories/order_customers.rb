FactoryBot.define do
  factory :order_customer do
    zipcode { '123-4567' }
    prefecture_id { 2 }
    city { Faker::Address.city }
    address_line { Faker::Address.street_address }
    building { '柳ビル103' }
    phone_number { Faker::Number.number(digits: 11) }
    token { 'tok_abcdefghijk00000000000000000' }
  end
end
