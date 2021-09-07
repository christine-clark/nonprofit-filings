# frozen_string_literal: true

FactoryBot.define do
  factory :award do
    grant_cash_amount { 1000 }
    grant_purpose { 'Grant purpose' }
  end
end
