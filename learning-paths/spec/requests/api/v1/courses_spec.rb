require 'rails_helper'

RSpec.describe "Api::V1::Courses", type: :request do
  let(:author) { create :author }
  let(:learning_path) {create :learning_path}
  let(:params) do
    { course: {
      name: 'Docker',
      description: 'learn about docker',
      order: 1,
      author_id: author.id,
      learning_path_id: learning_path.id
    } }
  end
  describe 'GET courses#index' do
    it 'should get index' do
      create :course, author: author, learning_path: learning_path
      get api_v1_courses_path
      json = JSON.parse(response.body)
      expect(response).to have_http_status(200)
      expect(json.length).to eq(1)
    end
  end

  describe 'GET courses#show' do
    let(:course) { create :course, author: author, learning_path: learning_path }
    it 'renders a successful response' do
      get api_v1_course_path(course)
      json = JSON.parse(response.body)
      expect(response).to be_successful
      expect(json['name']).to eq(course.name)
      expect(json['id']).to eq(course.id)
    end
  end

  describe 'POST courses#create' do
    it 'should create new course with valid attributes' do
      post api_v1_courses_path, params: params.to_json, headers: { "Content-Type": 'application/json' }
      json = JSON.parse(response.body)
      expect(response).to have_http_status(201)
      expect(json['name']).to eq('Docker')
      expect(json['order']).to eq(1)
      expect(json['description']).to eq('learn about docker')
      expect(json['author_id']).to eq(author.id)
      expect(json['learning_path_id']).to eq(learning_path.id)
    end
  end

  describe 'PUT courses#update' do
    let(:course) { create :course, author: author, learning_path: learning_path }
    it 'should update the bio' do
      update_params = { course: {
        description: 'learn about Ruby on rails API',
      } }

      put api_v1_course_path(course), params: update_params.to_json,
                                          headers: { "Content-Type": 'application/json' }
      json = JSON.parse(response.body)
      expect(json['description']).to eq('learn about Ruby on rails API')
    end
  end

  describe "GET /destroy" do
    let(:course) { create :course, author: author, learning_path: learning_path }
    it 'removes the course from the table' do
      delete api_v1_course_path(course), headers: { "Content-Type": 'application/json' }
      expect(response).to have_http_status(200)
      deleted_course = Course.where(id: course.id).limit(1).first
      expect(deleted_course).to eq(nil)
    end
  end
    
end
