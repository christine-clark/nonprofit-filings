FactoryBot.define do
  factory :receiver do
    ein { rand(10 ** 8...10 ** 9) }
    name { 'My Receiver Business' }
    address { '123 Sunny Skies Drive' }
    city { 'Orlando' }
    state { 'FL' }
    postal_code { 32825 }
  end
end