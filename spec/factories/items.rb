FactoryBot.define do
  factory :item do
    name           { Faker::Commerce.product_name }
    explanation    { Faker::Lorem.sentence }
    category       { Category.all.sample }
    condition      { Condition.all.sample }
    shipping_fee   { ShippingFee.all.sample }
    prefecture     { Prefecture.all.sample }
    delivery_date  { DeliveryDate.all.sample }
    price          { Faker::Number.between(from: 300, to: 9_999_999) }

    association :user

    after(:build) do |item|
      item.image.attach(io: File.open('public/images/test_image.png'), filename: 'test_image.png')
    end
  end
end
