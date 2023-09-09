require 'rails_helper'

RSpec.describe "Api::V1::Authors", type: :request do
  let(:params) do
    { author: {
      firstname: 'Jane',
      lastname: 'Doe',
      bio: 'hello i am an author'
    } }
  end
  describe 'GET authors#index' do
    it 'should get index' do
      create :author
      create :author
      get api_v1_authors_path
      json = JSON.parse(response.body)
      expect(response).to have_http_status(200)
      expect(json.length).to eq(2)
    end
  end

  describe 'POST authors#create' do
    it 'should create new author with valid attributes' do
      post api_v1_authors_path, params: params.to_json, headers: { "Content-Type": 'application/json' }
      json = JSON.parse(response.body)
      expect(response).to have_http_status(201)
      expect(json['firstname']).to eq('Jane')
      expect(json['lastname']).to eq('Doe')
      expect(json['bio']).to eq('hello i am an author')
    end
  end

  describe 'PUT authors#update' do
    let(:author) { create :author }
    it 'should update the bio' do
      new_author_params = { author: {
        firstname: 'Donna',
        lastname: 'Mwiine'
      } }

      put api_v1_author_path(author), params: new_author_params.to_json,
                                          headers: { "Content-Type": 'application/json' }
      json = JSON.parse(response.body)
      expect(json['firstname']).to eq('Donna')
      expect(json['lastname']).to eq('Mwiine')
      expect(json['bio']).to eq(author.bio)
    end
  end

  describe 'GET authors#show' do
    let(:author) { create :author }
    it 'renders a successful response' do
      get api_v1_author_path(author)
      expect(response).to be_successful
    end
  end

  describe 'DELETE authors#destroy' do
    let(:author1) { create :author }
    let(:author2) { create :author }
    let(:learning_path) {create :learning_path}
    let(:delete_params) do 
      {
        author: {
          author_id: author2.id
        }
      }
    end
    it 'removes author from table' do
      delete api_v1_author_path(author1), params: delete_params.to_json,
                                             headers: { "Content-Type": 'application/json' }
      expect(response).to have_http_status(200)
      author = Author.where(id: author1.id).limit(1).first
      expect(author).to eq(nil)
    end

    it 'updates course author to new author' do
      course = create :course, author: author1, learning_path: learning_path
      delete api_v1_author_path(author1), params: delete_params.to_json,
                                             headers: { "Content-Type": 'application/json' }
      updated_course = Course.where(id: course.id).limit(1).first
      expect(response).to have_http_status(200)
      expect(updated_course.author_id).to eq(author2.id)
      
    end
  end
end
