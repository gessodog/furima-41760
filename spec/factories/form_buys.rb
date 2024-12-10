FactoryBot.define do
  factory :form_buy do
    token             {"tok_abcdefghijk00000000000000000"}
    zipcode           {"123-4567"}
    prefecture_id     {"2"}
    city              {"test"}
    house_number      {"test"}
    building          {"test"}
    telephone_number  {"09011112222"}
  end
end