require 'rails_helper'

RSpec.describe "Api::V1::Talents", type: :request do
  let(:author) { create :author }
  let(:talent) { create :talent, author: author}
  let(:params) do
    { talent: {
      username: 'JaneDoe',
      email: 'test@gmail.com',
    } }
  end
  describe 'GET talents#index' do
    it 'should get index' do
      create :talent, author: author
      get api_v1_talents_path
      json = JSON.parse(response.body)
      expect(response).to have_http_status(200)
      expect(json.length).to eq(1)
    end
  end

  describe 'GET talents#show' do
    it 'renders a successful response' do
      get api_v1_talent_path(talent)
      json = JSON.parse(response.body)
      expect(response).to be_successful
      expect(json['username']).to eq(talent.username)
      expect(json['email']).to eq(talent.email)
    end
  end

  describe 'POST talents#create' do
    it 'should create new talent with valid attributes' do
      post api_v1_talents_path, params: params.to_json, headers: { "Content-Type": 'application/json' }
      json = JSON.parse(response.body)
      expect(response).to have_http_status(201)
      expect(json['username']).to eq('JaneDoe')
      expect(json['email']).to eq('test@gmail.com')
    
    end
  end

  describe 'PUT talents#update' do
    it 'should update the bio' do
      update_params = { talent: {
        username: 'JDoe',
      } }

      put api_v1_talent_path(talent), params: update_params.to_json,
                                          headers: { "Content-Type": 'application/json' }
      json = JSON.parse(response.body)
      expect(json['username']).to eq('JDoe')
    end
  end

  describe "GET /destroy" do
    it 'removes the talent from the table' do
      delete api_v1_talent_path(talent), headers: { "Content-Type": 'application/json' }
      expect(response).to have_http_status(200)
      deleted_talent = Talent.where(id: talent.id).limit(1).first
      expect(deleted_talent).to eq(nil)
    end
  end

end
