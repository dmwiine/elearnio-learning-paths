require 'rails_helper'

RSpec.describe "Api::V1::LearningPaths", type: :request do
  let(:learning_path) { create :learning_path }
  let(:params) do
    { learning_path: {
      name: 'Learning Path 1',
      description: 'Our first learning path',
    } }
  end
  describe 'GET learning_paths#index' do
    it 'should get index' do
      create :learning_path
      get api_v1_learning_paths_path
      json = JSON.parse(response.body)
      expect(response).to have_http_status(200)
      expect(json.length).to eq(1)
    end
  end

  describe 'GET learning_paths#show' do
    it 'renders a successful response' do
      get api_v1_learning_path_path(learning_path)
      json = JSON.parse(response.body)
      expect(response).to be_successful
      expect(json['name']).to eq(learning_path.name)
      expect(json['description']).to eq(learning_path.description)
    end
  end

  describe 'POST learning_paths#create' do
    it 'should create new learning_path with valid attributes' do
      post api_v1_learning_paths_path, params: params.to_json, headers: { "Content-Type": 'application/json' }
      json = JSON.parse(response.body)
      expect(response).to have_http_status(201)
      expect(json['name']).to eq('Learning Path 1')
      expect(json['description']).to eq('Our first learning path')
    
    end
  end

  describe 'PUT learning_paths#update' do
    it 'should update the name' do
      update_params = { learning_path: {
        name: 'Biology',
      } }

      put api_v1_learning_path_path(learning_path), params: update_params.to_json,
                                          headers: { "Content-Type": 'application/json' }
      json = JSON.parse(response.body)
      expect(json['name']).to eq('Biology')
    end
  end

  describe "GET /destroy" do
    it 'removes the learning_path from the table' do
      delete api_v1_learning_path_path(learning_path), headers: { "Content-Type": 'application/json' }
      expect(response).to have_http_status(200)
      deleted_learning_path = LearningPath.where(id: learning_path.id).limit(1).first
      expect(deleted_learning_path).to eq(nil)
    end
  end
end
