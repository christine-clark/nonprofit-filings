# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Receiver, type: :model do
  describe 'validate model' do
    subject do
      described_class.new(ein: 123_456_789, name: 'My Business', address: '123 Somewhere Street', city: 'Orlando',
                          state: 'FL', postal_code: '32825', awards: [])
    end

    it 'is valid with valid attributes' do
      expect(subject).to be_valid
    end

    it 'ein is invalid when more than 9 digits long' do
      subject.ein = 1_234_567_890
      expect(subject).to_not be_valid
      expect(subject.errors.first.message).to eq('EIN must be 9 digits long')
    end

    it 'postal code is invalid when does not match format 12345' do
      subject.postal_code = 3_423_423_479
      expect(subject).to_not be_valid
      expect(subject.errors.first.message).to eq('Postal code should be formatted as 12345 or 12345-1234')
    end

    it 'postal code is invalid when does not match format 12345-4321' do
      subject.postal_code = 342_342 - 3479
      expect(subject).to_not be_valid
      expect(subject.errors.first.message).to eq('Postal code should be formatted as 12345 or 12345-1234')
    end
  end

  describe 'associations' do
    it 'can have many awards' do
      should have_many(:awards)
    end
  end
end
