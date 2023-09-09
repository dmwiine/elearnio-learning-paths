require 'rails_helper'

RSpec.describe "Api::V1::TalentLearningPaths", type: :request do
  let(:author) { create :author }
  let(:learning_path) {create :learning_path}
  let(:talent) { create :talent, author: author}
  let(:course1) { create :course, author: author, learning_path: learning_path, order: 1 }
  let(:course2) { create :course, author: author, learning_path: learning_path, order: 2 }
  let(:course3) { create :course, author: author, learning_path: learning_path, order: 3 }
  let(:params) do
    { talent_learning_path: {
      talent_id: talent.id,
      learning_path_id: learning_path.id,
      completed: false
    } }
  end
  describe 'POST talent_learning_paths#create' do
    it 'should create new talent course with valid attributes' do
      post api_v1_talent_learning_paths_path, params: params.to_json, headers: { "Content-Type": 'application/json' }
      json = JSON.parse(response.body)
      expect(response).to have_http_status(201)
      expect(json['talent_id']).to eq(talent.id)
      expect(json['learning_path_id']).to eq(learning_path.id)
      expect(json['completed']).to eq(false)
      
    end
  end

  describe 'PUT talent_learning_paths#update' do
    it 'should complete the current learning map' do
      update_params = { talent_learning_path: {
        completed: true,
      } }
      talent_learning_path = create :talent_learning_path, talent: talent, learning_path: learning_path
    
      put api_v1_talent_learning_path_path(talent_learning_path), params: update_params.to_json,
                                          headers: { "Content-Type": 'application/json' }
      json = JSON.parse(response.body)
      expect(json['completed']).to eq(true)
    end
  end

end
