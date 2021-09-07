# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Award, type: :model do
  describe 'associations' do
    it 'belongs to receiver' do
      should belong_to(:receiver)
    end
  end
end
