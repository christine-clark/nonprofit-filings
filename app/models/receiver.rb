class Receiver < ApplicationRecord
  scope :with_awards, -> (ein) { left_joins(:awards) }
  scope :filter_by_ein, -> (ein) { where(ein: ein) }
  scope :filter_by_name, -> (name) { where('name like ?', "%#{name}%") }
  scope :filter_by_state, -> (state) { where(state: state) }

  validates_length_of :ein, is: 9,  message: 'EIN must be 9 digits long'
  validates_format_of :postal_code, :with => /\A\d{5}-\d{4}|\A\d{5}\z/, :message => 'Postal code should be formatted as 12345 or 12345-1234'

  has_many :awards
end
