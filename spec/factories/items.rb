FactoryBot.define do
  factory :item do
    item_name              { 'test' }
    item_information       { Faker::Lorem.sentence }
    item_category_id       { '2' }
    item_state_id          { '2' }
    delivery_cost_id       { '2' }
    prefecture_id          { '2' }
    delivery_day_id        { '2' }
    price                  { '5000' }
    association :user

    after(:build) do |item|
      item.image.attach(io: File.open('public/images/test_image.png'), filename: 'test_image.png')
    end
  end
end
