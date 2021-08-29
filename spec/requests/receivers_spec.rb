require 'rails_helper'

RSpec.describe 'Receivers', type: :request do
  describe 'GET /index' do
    before(:each) do
      @receivers = create_list(:receiver, 3)
      @award = create(:award, { receiver: @receivers.first })
    end

    it 'should return receivers' do
      get '/receivers'

      first_receiver = @receivers.first
      current_receiver = json_response['data'][0]
      expect(response.status).to eq(200)
      expect(json_response['total_count']).to eq(3)
      expect(json_response['total_pages']).to eq(1)
      expect(current_receiver['ein']).to eq(first_receiver.ein)
      expect(current_receiver['name']).to eq(first_receiver.name)
      expect(current_receiver['address']).to eq(first_receiver.address)
      expect(current_receiver['city']).to eq(first_receiver.city)
      expect(current_receiver['state']).to eq(first_receiver.state)
      expect(current_receiver['postal_code']).to eq(first_receiver.postal_code)
      expect(current_receiver['awards'].length).to eq(1)
    end

    it 'should filter by ein' do
      first_receiver = @receivers.first

      get "/receivers?ein=#{first_receiver.ein}"

      current_receiver = json_response['data'][0]
      expect(response.status).to eq(200)
      expect(json_response['total_count']).to eq(1)
      expect(json_response['total_pages']).to eq(1)
      expect(current_receiver['ein']).to eq(first_receiver.ein)
    end

    it 'should filter by name' do
      first_receiver = @receivers.first

      get "/receivers?name=#{first_receiver.name}"

      current_receiver = json_response['data'][0]
      expect(response.status).to eq(200)
      expect(json_response['total_count']).to eq(3)
      expect(json_response['total_pages']).to eq(1)
      expect(current_receiver['name']).to eq(first_receiver.name)
    end

    it 'should filter by state' do
      first_receiver = @receivers.first

      get "/receivers?state=#{first_receiver.state}"

      current_receiver = json_response['data'][0]
      expect(response.status).to eq(200)
      expect(json_response['total_count']).to eq(3)
      expect(json_response['total_pages']).to eq(1)
      expect(current_receiver['state']).to eq(first_receiver.state)
    end
  end

  def response_body
    JSON.parse(response.body)
  end
end
