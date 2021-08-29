require 'rails_helper'

RSpec.describe Filer, type: :model do
  describe 'valid model' do
    subject { described_class.new(ein: 123456789, name: 'My Business', address: '123 Somewhere Street', city: 'Orlando', state: 'FL', postal_code: '32825') }

    it 'is valid with valid attributes' do
      expect(subject).to be_valid
    end

    it 'ein is invalid when more than 9 digits long' do
      subject.ein = 1234567890
      expect(subject).to_not be_valid
      expect(subject.errors.first.message).to eq('EIN must be 9 digits long')
    end

    it 'postal code is invalid when does not match format 12345' do
      subject.postal_code = 3423423479
      expect(subject).to_not be_valid
      expect(subject.errors.first.message).to eq('Postal code should be formatted as 12345 or 12345-1234')
    end

    it 'postal code is invalid when does not match format 12345-4321' do
      subject.postal_code = 342342-3479
      expect(subject).to_not be_valid
      expect(subject.errors.first.message).to eq('Postal code should be formatted as 12345 or 12345-1234')
    end
  end
end
