require 'rails_helper'

RSpec.describe 'Filers', type: :request do
  describe 'GET /index' do
    before(:each) do
      @filers = create_list(:filer, 3)
    end

    it 'should return filers' do
      get '/filers', :headers => { 'ACCEPT' => 'application/json' }

      first_filer = @filers.first
      current_filer = json_response['data'][0]
      expect(response.status).to eq(200)
      expect(json_response['total_count']).to eq(3)
      expect(json_response['total_pages']).to eq(1)
      expect(current_filer['ein']).to eq(first_filer.ein)
      expect(current_filer['name']).to eq(first_filer.name)
      expect(current_filer['address']).to eq(first_filer.address)
      expect(current_filer['city']).to eq(first_filer.city)
      expect(current_filer['state']).to eq(first_filer.state)
      expect(current_filer['postal_code']).to eq(first_filer.postal_code)
    end

    it 'should filter by ein' do
      first_filer = @filers.first

      get "/filers?ein=#{first_filer.ein}"

      current_filer = json_response['data'][0]
      expect(response.status).to eq(200)
      expect(json_response['total_count']).to eq(1)
      expect(json_response['total_pages']).to eq(1)
      expect(current_filer['ein']).to eq(first_filer.ein)
    end

    it 'should filter by name' do
      first_filer = @filers.first

      get "/filers?name=#{first_filer.name}"

      current_filer = json_response['data'][0]
      expect(response.status).to eq(200)
      expect(json_response['total_count']).to eq(3)
      expect(json_response['total_pages']).to eq(1)
      expect(current_filer['name']).to eq(first_filer.name)
    end

    it 'should filter by state' do
      first_filer = @filers.first

      get "/filers?state=#{first_filer.state}"

      current_filer = json_response['data'][0]
      expect(response.status).to eq(200)
      expect(json_response['total_count']).to eq(3)
      expect(json_response['total_pages']).to eq(1)
      expect(current_filer['state']).to eq(first_filer.state)
    end
  end
end
