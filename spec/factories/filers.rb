FactoryBot.define do
  factory :filer do
    ein { rand(10 ** 8...10 ** 9) }
    name { 'My Filer Business' }
    address { '123 Sunny Skies Drive' }
    city { 'Jacksonville' }
    state { 'FL' }
    postal_code { 32224 }
  end
end