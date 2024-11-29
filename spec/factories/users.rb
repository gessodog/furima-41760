FactoryBot.define do

  require 'faker'

  module CustomFaker
    module Alphanumeric
      extend self
  
      def alphanumeric_with_both(length)
        raise ArgumentError, "Length must be at least 2" if length < 2
  
        alphabets = ('a'..'z').to_a + ('A'..'Z').to_a
        digits = ('0'..'9').to_a
  
        result = []
        result << alphabets.sample
        result << digits.sample
  
        (length - 2).times do
          result << Faker::Alphanumeric.alphanumeric(number: 1)
        end
  
        result.shuffle.join
      end
    end
  end

  factory :user do
    nickname              {Faker::Name.initials(number: 2)}
    email                 {Faker::Internet.email}
    password              {CustomFaker::Alphanumeric.alphanumeric_with_both(6)}
    password_confirmation {password}
    first_name            {"あ亜ア"}
    last_name             {"あ亜ア"}
    first_name_kana       {"アイウ"}
    last_name_kana        {"アイウ"}
    birth                 {Faker::Date.birthday(min_age:5, max_age:94)}
  end
end


